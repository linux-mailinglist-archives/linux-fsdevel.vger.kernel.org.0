Return-Path: <linux-fsdevel+bounces-4865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F368054C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 13:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76382280948
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 12:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251594B5DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OK4zaIEE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MsjBr4oS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8BCB9;
	Tue,  5 Dec 2023 02:50:23 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5ATarH008762;
	Tue, 5 Dec 2023 10:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=aUwHFs/kOANQOITnej+rb4yMlD3xDnhdEORkX4bGh9E=;
 b=OK4zaIEEYHRrUPxMxC/PxyNK2C24b3/Eg3U2F/s+w9kAIwamUQLYUoSh5Z3g+9RnUhH8
 rFoLZpzUI7lJwSKBwCz9VCHarsvfcAOTza1CFKXgmBDupxpETmiZYxHRp9HTIgkMrOai
 x8v+Ebu23cE98mnW8V2bIrCkcv0RFnLoM9IbgPEFc2gGllyGwiLmZkwKapKgq1WUl+W0
 TxMm/HiAIjcLkzrBKuCOfkLQQByp9XUr9ZWhEL5Y/pzfh7Du/kqKTiPMrSr9WIpFU39T
 OyldhJmElvQY4PZHPg9vNBD8YXfFiczFI4J6fs4AZsRcNuwwVnyz14JA/RI0QlgsZVo7 FQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ut0xw89pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Dec 2023 10:49:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B59WqiM018432;
	Tue, 5 Dec 2023 10:49:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu177yev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Dec 2023 10:49:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U20oE5ksvJ8BYvveEXYHz9LnaPNCZs6afeFon5hkrwfSoBlg5XdlKTEGibTc/8I3z0DYFP1Ik5fl1Ryq5ak+YEUZllYwAsImdy9dRwSC9rFNwas62ESrR58pn6Qvvving/B4ggs+BSxMLvk/rxTZ0t78XDA/EZX2xqayPa1kcgNAHeCnQ9DKb2JEc5FuL9lgRdJA9DGOQWVNttSG7ss9qfqjeRdY5O/TBiuCPfEcSOJTlTOqJcgiBFMmblBEwXBRcu3zQu+lPzNGtLz0ARh83jdMMoIBtb62/UTTSKBRbixPSZJH3rni7VvgNMBlM3vLdkQF0uK8/zTKx90MgRWUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUwHFs/kOANQOITnej+rb4yMlD3xDnhdEORkX4bGh9E=;
 b=Zg0iKTlD4kefEYO4iFcq5jtThGyLqVPgjVJLFB6rVER8SH+wGuR56nFrEwr7wDXijXuI/7lbPaiK5c9wICD3seFHxtVqnXC9pMtWX+lov2bikRvBEr9K5tUdyGqPnrnPdN3wK/SV0zpSheDIbW9/wH0J6+a9EnSERh/UMDA8hz9ZaJqK2MKhGyp4OL3Xy7BD3N9AJ+ci/zk3tpDmy0PIqExAMon4LRgulk/XbV+kpACPaFab78B8JxR5UbwmyssbNbimu8rvnGQ9dIkzZJJzX+SrbSAYsAlBJALoOGBhXQx2auZxESw22jc9z0vAZd3gguDa4Ast+tLUvHp944pvrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUwHFs/kOANQOITnej+rb4yMlD3xDnhdEORkX4bGh9E=;
 b=MsjBr4oSy8YggfVVvqD5WuU5A6puMlbokNCoM4MhgSiKxECZuBwRXB4G8J2sj/w3ishlA6l1iGlJrMFrNqFPXhp/BKQFPwfBXcKL//L26jLnCVjtQR0YpGPnY1S78fDWYUXKhtmixFQ6W4Pc75zDygQwJjJioqVdBWf82yV5mIg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB7029.namprd10.prod.outlook.com (2603:10b6:806:346::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 10:49:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 10:49:54 +0000
Message-ID: <c8ef6c57-5e3a-4c12-9f0f-a2e1b1e49ddc@oracle.com>
Date: Tue, 5 Dec 2023 10:49:49 +0000
User-Agent: Mozilla Thunderbird
From: John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, chandan.babu@oracle.com,
        dchinner@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com> <ZW05th/c0sNbM2Zf@fedora>
 <03a87103-0721-412c-92f5-9fd605dc0c74@oracle.com> <ZW3DracIEH7uTyEA@fedora>
 <bd639010-2ad7-4379-ba0a-64b5f6ebec41@oracle.com> <ZW6A0R04Gk/04EHj@fedora>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <ZW6A0R04Gk/04EHj@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0049.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f1ffe5-6b04-42b3-bb19-08dbf57fea2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CfRYh11NyMV4zACCikr3CgbVmOzb3geUP+BOXW0+nnFk2nkXlOYoRJn8KYdsAcxBDTWnElHo6c+wbO9iNaOv/sTCVF8sFfvfaaC1aCmOMXYtABPGcdeQ8YLZ521I/vhNGKgjA27xNGUPzvKmkmaLaGstq8ihstV189I6LO5qmAtilMg5CKyfD7k8RbrKsTl5AqZVfDcGhS5MXsmRJqyj0oqSW61VrY2ulvG7fZo4K1ruV9mWpeckWA0n0xsigtfH+m/AAPesakW+UzLTW4I3JTkqAzXeHLl7/bKG33UpbKNcl2tw1rmdywvt7BMz1WBoTUmE+Fz9WzczmOklP3EeDFdAXEOGDUHXvkT0dtcXT1jlt0qGdoF4+FP/cbis2tx0+zH8p2d86A+PyJGBKb2luZNNkQhkf3qs/5VBO1FEgEtzqxc6xZo43MicB9rWftHAvaWxQs5rKz/FXBEo+QCLNlE0fwuUcpSDQXbhKonXzjoSOnPLiThDZ3GsVCObM8nWlRf4OncyLCOXnoEF1IhHyYe8oXiAXDVEIA/yuvYPEzudVs/cMb5PoZ3ieR/D2ptuE6tMmjRXEhJRgR9a95A8860iuzGSmFz6Pt78X9stEZSHnmKDv/4LbRG5wljVl0NgkCaGHXZjAQ9xnRWxnJ2ESA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(53546011)(2616005)(41300700001)(6512007)(36756003)(86362001)(83380400001)(31696002)(26005)(6486002)(316002)(6916009)(66476007)(66946007)(66556008)(6666004)(4326008)(8676002)(8936002)(36916002)(6506007)(478600001)(31686004)(38100700002)(7416002)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RmtnZEQ5TzFkMTYvRm1SZmhRK0o2MVBKN1pvOEQzTXJOSUh4Y0RTRER6Vng1?=
 =?utf-8?B?RHNUd3NLaE1MOUJzVU9RaWRiWjFUMDRsS2VUK250dUIrajZXbnI3R0pFYml6?=
 =?utf-8?B?c1RKSmZCc21lanprQTNaSmVYRC9YRFlVY3Z6dTVnV1YrcW9WQld3dDlNNVRZ?=
 =?utf-8?B?bHh2R0UrTXZGd0NkVGtTNVZldk5CeE9oRmZacXlUWGFwTm5meFVZSDVnUnc3?=
 =?utf-8?B?K2Z0VlFQc1JLcDBMa2doY285bytCVDRjNGg1R2NURlcxbnhYTE40dWpNT0xr?=
 =?utf-8?B?Mm44MmYxQlpxUURDcENWbENOMkhzMFRWRXhwMFJEbEl5NVRpNXJEU0pRT1lF?=
 =?utf-8?B?V2wrR1F3ZWhuVmtMV1hFS3hHeDJSUkVpSHRmZHpVR1hlaGEzSUlCampJK2V6?=
 =?utf-8?B?RE52WUdWSWY4MUsxaDBRNVA4L05nN2hSNGl2SjBKVkxsQk1MNVViY0NZNnFy?=
 =?utf-8?B?cDlldVpkUWtTSjhtbUthS2NEbUdWWk14dlg0emJsbHprUm41S3BXNXZMNHBZ?=
 =?utf-8?B?cTQ5R1lHS0p5OHVwK3lrbjJxRzl4RDhHVSs1SDMrV0MyaVFYZWlxbmxKUEF3?=
 =?utf-8?B?VXlkdjA2bUNBekdNUHdMcWh6N2l2R25UREhoS1UrVTFXai9xWHdmcExXTFNo?=
 =?utf-8?B?d1M0SCtlVmhtUnNRN3FJdS82U0kvUzA0ZEFNY000eVJYdXNzZVFPMFdnYXh1?=
 =?utf-8?B?cFE2b2lUWjBXdWxrSlJyazZWUDRwemR5ZXdWUTVOcU1UM1FJK055SmppY1l2?=
 =?utf-8?B?b2lJOCt3N3hhaGx5TWlGTjVxWXFScXd1VlF5d0dYUUhvRndyNVJETGZ1UmRJ?=
 =?utf-8?B?ZkYxdWZINjBkQ0luTlJpTHl3eGdoVThVcHdEU0JEMHlGTVJVSGMwY1czOUMz?=
 =?utf-8?B?WUpLR1d4Nkd3dHErNzJKblhMczNaY0cyTmh2REdQRW9jeGpLSHFZS0FZUzZs?=
 =?utf-8?B?ZG83bUNKS3ZZaEc0TWVFblZPTzlGNHF6NGlkdmxDVnBTTjcvM05TRnpSVFNF?=
 =?utf-8?B?QU1kb014UlNXbmttZWhUTGdNendDWWtqWjFobVVHbGdHR2VRZFZ4aXlwd3ZX?=
 =?utf-8?B?d1JWc2VMSjArR0Z1bHBrVUJaNWl2M08vYmFxd3NXbDN1THFSeU0vWC9nS3ZD?=
 =?utf-8?B?QVliT3hGMUJyc3czYXB6anpxS3R2MGZJRFFWTVUzOGZjQUFyT2ZsdGEyOTJh?=
 =?utf-8?B?N1lDNXBNL0hFLzA4ZE5jZ01wb3dyNDRhTjBLWXlTTm5uWUduZEtIK0s4SDN5?=
 =?utf-8?B?WXFxNXQwZUhTRitpMGw3T2hPTkJVcjNSWjM2TGE5NGhhRzdPa1hmZTBOd3ho?=
 =?utf-8?B?UEdyNU1oQXBYYjhxK3FIYjFWRSsyNjNTVFB6UW9OaEpodldFWlZrYWpOWUpV?=
 =?utf-8?B?aXpyODVSdWZjb3VleFNxUFVNYllDclBueTNWVHRUL1B1ZWpRSU9rL3g1YXdy?=
 =?utf-8?B?Q1RUdTN4WXA5YVBrTkdZZU1kUCsyYlBLcTJxS205aUN3MWI4bExMTUkwZHhz?=
 =?utf-8?B?MGJSTWZQR0l0c0tSNXdsUlpOMkFWZmJHZDR5V0lKV0tUZzd2Y1V4SVRxbEVI?=
 =?utf-8?B?WGM3VXFjN2xNWkpaY3dOMFRRaUFqTFY4RzErR0lteTNMcjFFSi9KbFRYRVRK?=
 =?utf-8?B?allQWDc4MG9WWkZWZlQyeVZBY3RxQnc4amdJR3ZxQTFaUUZKMlNOQmNYNThJ?=
 =?utf-8?B?TFF5MmJydERzZmhPc3FPOGwxMk9vbStJVTBuTUhQREExTCs4YnFTNzVBL04w?=
 =?utf-8?B?bnVvYWd3S2Q5a3ZYV1JSSUNuTCtKU0dUU2dMOEErbVoxTEJBcVdvSzRiMllM?=
 =?utf-8?B?M1dwUndxc2k2TjQ2THV4dEZZQjFnY3JlMnFVL2hWbVFsMGJETFBXNWJNeHlW?=
 =?utf-8?B?VFJ0ZjljaGI1RnhoSTJnSStPcytJc3poWDc5Rlh0d3hZTkZhMERDTjhMUXJR?=
 =?utf-8?B?V2JDWk5NZDR5OEc1eUlJTFdjQWlOa3RpNU9pZ1d6SytqcDRiYnE1QzhJMUds?=
 =?utf-8?B?ZllSTXZRRUdRSFpKLy9NbURwOExBZEY4OXY4U2Q2end3RXhOVXVaMXU1UUw1?=
 =?utf-8?B?a0pQaTlFUy8wb0wwR3FhNmFjeFRVbWlQaWpHemdZSmJWeFkwTHpRN0J0cXRO?=
 =?utf-8?Q?+8mCx5iR+PZ0ZMf0lI1LL2nOo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?aFlEMkIxSVhsZGxwUVNRcDJqM1FmVGpVeGlkVWZQNVBzYlM1NVJPTkxxcmVh?=
 =?utf-8?B?M3RhYkNheGJDa2FVZTRDZUVQWHAyKzU1NTVEY2Nxd3pFRjVGTkwwcXMwdm1k?=
 =?utf-8?B?TWRjc3FmeWNpMGxJaTFJdHlsS2tCM3RTSSttejBqZEhvMThZcjY4RUw1eEZF?=
 =?utf-8?B?Yk00OFNFYW0yazlYSmtrOHBWREphMWJrZys1eXVxRUtWdTJmWHZqTlJJSERC?=
 =?utf-8?B?bVJjcTVBdmpYU2xCSU5WaHFNTll5emh0SlY3WEJLOEUwbWFjdk52WEZLck9u?=
 =?utf-8?B?cmNlUUk0VURvNm9DejZtTTZQZ0RlMW9kUjZaMVY4czVwa2p5b2dHMWU0QzBW?=
 =?utf-8?B?TnRvalpSdUpheFFaektsVDE0T0hHSWwvYUEzb0ZObkNvbWd1ZU1PZzBkVDZP?=
 =?utf-8?B?VmdpMEJTaGdsbE93WFlIaVRVaElmUGRzTnR5Rmg3T09xZVJVTXFqWlBCeExr?=
 =?utf-8?B?aDJqSG9WaVVzeVYwR0ErMkttVkJDZXh4M1dCdDIxWUIrYnlLeEdVQWIwbCtQ?=
 =?utf-8?B?dFI1b01SSVhEK0NRSkt0a1pSeG9LaVBoMkYxUXpEUHFGWE5jbEFVa2NXL3N2?=
 =?utf-8?B?VEk4RnpOWW1kUWttVTNMZWcrK0hObEFUZnQ2RzZCenpjZGo0TzJzMmd0MFVD?=
 =?utf-8?B?S2g2OTJ4aFZtaFc5THlLaEdvWTVrcjdlaDR4V2pITEFzYjdHTkdjQmdlS2k4?=
 =?utf-8?B?dkJQa0pmY3hNeFNINFEyc21WMFpSTldJellSQTlHZWl4V1pPOXJhaUhiSWdL?=
 =?utf-8?B?d0h2RG5ERDhQUTJMT01NUmVpVjRjdDZqS2RpQXNNdytkQk1HU2kzRXdmbmNM?=
 =?utf-8?B?dFA3ZDIvdnUvaVBYWTg1WHkySGo2TzZQaGN5bkZwUUxtRjlMK3JVS2Q2YUhz?=
 =?utf-8?B?UkVvSHBYRDlrQko4STY2NkdQRlRoL2YxLy9CTE1lejh5UnY4V1Z6RFJ3VmFk?=
 =?utf-8?B?d0ZmN2RRV0NqS3ZZWW41c2JUTURDaHQyd0FNQWR4UEN0a28vMzBqREt1dGZM?=
 =?utf-8?B?NnhIelBkaEVqc2xNWXZzUHEyT1hiMlcweUhScUo5QW1mUkcyVjYvWnNYNkpI?=
 =?utf-8?B?ZE90c0lOenZqaHdodDBaOU9vMTNtUW1LS3dtZXNqS0ErQXBXdWN2TEtTeEI1?=
 =?utf-8?B?Q3U4aXVkSWZaMjJ1RlpYL0JGK1I1UlBpQS9QVUtLc1lwYWRoZkt4emYzTTND?=
 =?utf-8?B?V2pzTFNWdk5GcmxOd2p4dFkrb3E1WnYyRm1EOGNoSUlwbzJXWG5wVzlXZWkr?=
 =?utf-8?B?TjlzakhHMkc4NlZCaStwUHQ3aHBsMVlNUTR4ZDZyaE9McWxxcnlhSHVBVEdL?=
 =?utf-8?B?NXdwbzZxc25VcmRKck9NRUV1azVNK0tSSkJSalBWc21UY01kRkpCWFV0SjZy?=
 =?utf-8?B?Y05iZ0xDSHhyaGJZbVEvYjVGSEw1eUhUREp0Um5DK2dDNkljVnRXcXphN1JT?=
 =?utf-8?B?ZXpFWTY4QUM2amJSRWxsKzRUSUt1cWw1a2t6TEVnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f1ffe5-6b04-42b3-bb19-08dbf57fea2d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 10:49:54.3727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiOwUs5OLHM+Y0tHSs01DxXUS4GtFUQ0VLC3gt7rZVyJh8yJCr9xPIshFFhTWZxu3pZEUJRC2yok87QCHBGPSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7029
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_05,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050086
X-Proofpoint-ORIG-GUID: YFRaGwbod_tIGaYt3ja9Szj-47iLa6qz
X-Proofpoint-GUID: YFRaGwbod_tIGaYt3ja9Szj-47iLa6qz

On 05/12/2023 01:45, Ming Lei wrote:
>> Right, we do expect userspace to use a fixed block size, but we give scope
>> in the API to use variable size.
> Maybe it is enough to just take atomic_write_unit_min_bytes
> only, and allow length to be N * atomic_write_unit_min_bytes.
> 
> But it may violate atomic write boundary?

About atomic boundary, we just don't allow a merge which will result in 
a write which will straddle a boundary as there are no guarantees of 
atomicity then.

Having said this, atomic write boundary is just relevant to NVMe, so if 
we don't have merges there, then we could just omit this code.

> 
>>> The hardware should recognize unit size by start LBA, and check if length is
>>> valid, so probably the interface might be relaxed to:
>>>
>>> 1) start lba is unit aligned, and this unit is in the supported unit
>>> range(power_2 in [unit_min, unit_max])
>>>
>>> 2) length needs to be:
>>>
>>> - N * this_unit_size
>>> - <= atomic_write_max_bytes
>> Please note that we also need to consider:
>> - any atomic write boundary (from NVMe)
> Can you provide actual NVMe boundary value?
> 
> Firstly natural aligned write won't cross boundary, so boundary should
> be >= write_unit_max,

Correct

> see blow code from patch 10/21:
> 
> +static bool bio_straddles_atomic_write_boundary(loff_t bi_sector,
> +				unsigned int bi_size,
> +				unsigned int boundary)
> +{
> +	loff_t start = bi_sector << SECTOR_SHIFT;
> +	loff_t end = start + bi_size;
> +	loff_t start_mod = start % boundary;
> +	loff_t end_mod = end % boundary;
> +
> +	if (end - start > boundary)
> +		return true;
> +	if ((start_mod > end_mod) && (start_mod && end_mod))
> +		return true;
> +
> +	return false;
> +}
> +
> 
> Then if the WRITE size is <= boundary, the above function should return
> false, right? 

Actually if WRITE > boundary then we must be crossing a boundary and 
should return true, which is what the first condition checks.

However 2x naturally-aligned atomic writes could be less than 
atomic_write_max_bytes but still straddle if merged.

> Looks like it is power_of(2) & aligned atomic_write_max_bytes?
> 
>> - virt boundary (from NVMe)
> virt boundary is applied on bv_offset and bv_len, and NVMe's virt
> bounary is (4k - 1), it shouldn't be one issue in reality.

On a related topic, as I understand, for NVMe we just split bios 
according to virt boundary for PRP, but we won't always use PRP. So is 
there value in not splitting bio according to PRP if SGL will actually 
be used?

> 
>> And, as I mentioned elsewhere, I am still not 100% comfortable that we don't
>> pay attention to regular max_sectors_kb...
> max_sectors_kb should be bigger than atomic_write_max_bytes actually,
> then what is your concern?

My concern is that we don't enforce that, so we may issue atomic writes 
which exceed max_sectors_kb.

If we did enforce it, then atomic_write_unit_min_bytes, 
atomic_write_unit_max_bytes, and atomic_write_max_bytes all need to be 
limited according to max_sectors_kb.

Thanks,
John

