Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9347B76A244
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 22:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjGaUzu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 16:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGaUzt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:55:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE2D10C0;
        Mon, 31 Jul 2023 13:55:48 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VKgKUj009101;
        Mon, 31 Jul 2023 20:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=2QmyfbIBTBwlEVwpSBBt9e6sQ1OaDHqcy/OvutzIpUc=;
 b=0qrc3Ar9ZHO3yXYi5Rq/zh0kFYMpZTyk24yNHQcnUe6D4e6+StldrxPjGAZuMqkMO7cH
 rO0WopYOdieqxkLtzD4GT2RaPCaOClI/pzp119JW6QO3uKPSkJ7eXuE9nx7YGN143c3/
 HsMRiMkR1LwOdAdPsTWPYHjBFDLnK7cOaVLkOiNKXRbOx7ydm30Na9OrXhx1jazNj7cy
 CuwAUPpqxiOaS7zF8O4mtgKZiAgjgZw+eEFLoYadw/x4WNpBQjAvzkum0l0PpnhL6Y+7
 hGxEbn2LXWn3Z6ezS0UDJocJEG04KfO8bmP31vDTg5XEnpWaIdIhQjtlzaCNBnJgSmT5 MA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tctuhyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 20:55:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VKrpCS013577;
        Mon, 31 Jul 2023 20:55:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s75fjtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 20:55:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCzJA5kOTLrmKAh9eDjWR5PGF2WFdKKbXGK2ZqXxLJ/l3rFhBjBXhBYuzZMeTzGppNNilTef25dvDJ+7LGMQ1HOv16Aoj0Vp1i0wToCy/NGO9SbHEE4sSOWKM1IwXttUAS9FancNALEXs+cfGmaDr3dtdbRJB203SuuGyZArLbfNqdoUrwC/uKH7nMbzCp/CDMRbFHm4324/C6jHH7al8BWMyvZq4nWh8ZNJEMe1VAFQgp9uWWRDWC1Oba4aOIX88Q1t51EvPsxmDUJ+Ztx+T5INgj+3QFwVtIrMxm9tgIoZCvr70MfjXpEdZCYtamO0wLv/b4g0TFPs6lfO0dZK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QmyfbIBTBwlEVwpSBBt9e6sQ1OaDHqcy/OvutzIpUc=;
 b=J3cs9oYn2+X9ax9EB4+9nCMFP93KKs76Vad58k13hf9J1RWDdf3oDnJA8SfYf7k40daMDEyxemPywyjfEptvGndi38pzBQiEprztATsb5OAxA+DYfQhjTnAtfFHId5pUg/saBIY93fhul78tBuB6kYB2L+qqKpNFxXzTFtso+1Co0uzZVxMS3/5Csr8PgLHtWBSoQ8RE2RUARf9JUscrMyXEttpClpGPPvNAGcwJte8OUm26fudGI/78GkXL1Rk/tFnAGSwpM3FmfFtPmojms3dCCCsIjdg6VEiSXXFS5NDlv3Emb6qe20SXQK9/PTz/sBV8LuJONFU/WZv3+wOC8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QmyfbIBTBwlEVwpSBBt9e6sQ1OaDHqcy/OvutzIpUc=;
 b=KacdfipPCsMu3mVkSTXcpjmlolkgSk+nZigMmlCFxr25mBDCmL24JW2cR0quaVMky85EEK1DovYf6ywkJPvxluX97YunKwgP4Vh6pmldausHhG9JcWtgg4gdyQ8kLPt0JermkCy3GjSSYnNRf7+Jcj5rOVWBYvJbyMVg8RGqP/E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB6293.namprd10.prod.outlook.com (2603:10b6:806:250::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 20:55:14 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 20:55:14 +0000
Date:   Mon, 31 Jul 2023 16:55:10 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        npiggin@gmail.com, mathieu.desnoyers@efficios.com,
        peterz@infradead.org, michael.christie@oracle.com,
        surenb@google.com, willy@infradead.org, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, avagin@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] MAINTAINERS: Add co-maintainer for maple tree
Message-ID: <20230731205510.eildrxnrrsucuisl@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        npiggin@gmail.com, mathieu.desnoyers@efficios.com,
        peterz@infradead.org, michael.christie@oracle.com,
        surenb@google.com, willy@infradead.org, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, avagin@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-11-zhangpeng.00@bytedance.com>
 <20230726163955.r47vbkgjrcbg6iwv@revolver>
 <763e286d-8621-0dcc-bb9b-99eb053bc148@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <763e286d-8621-0dcc-bb9b-99eb053bc148@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0298.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 5670f299-c06d-4ac4-1c79-08db92087019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mLtBsX3vvwXSMSCsiQ0SY8yoEaMJ/oR7oUGRex3sOU6it7ITXtMHrCTarvPT3hwvHNs0k51r7F1E02zzIUFIptSiL6/0X/wdGW77uKjn66vceX75Q4vieM3Dobqontv8YaCy7cTYXo40vDVeeR7Lwy/f/NuX88w04jqvi9CbQgRJoj1gm1j433EWsCi/401QM0yW/JUiAisgHC8dz2jRf+PFqFX+AyoaoJEdn978h+oDyZG7UsnWCwM91LkR8zJqe+iaAhVv5kTMu5aZo9V+28txABVn1cDuI8zViSY7d+eHPdeUFDpgaJowi+xA5QeTRiqlUpyVJpNg/wfAyraMRV+U3weCM2BAXWftuoqazPncS1eqJdPR3KVyz8pgaxc0MjBt4fqzenahyOTw7TM7cBRgBigJ4pdfUaVN40dgJWdxnmj7wxNTGJ21cVuuBc1Wxd79dgWHZ24+PLKJiI803bJwekpdn+qg80QJD5caJpvhcuNwdy02Dmu0V0D5bcZBBeUPk1ee2oYvuM5g63uM63mZouG7urmMXGHZVkuaquEP7sakOaN6CAJzPvTkt8J1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199021)(33716001)(478600001)(38100700002)(86362001)(6512007)(9686003)(6486002)(6666004)(7416002)(186003)(8676002)(1076003)(26005)(8936002)(6506007)(5660300002)(4326008)(3716004)(2906002)(66946007)(6916009)(66476007)(66556008)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWdNT25qMW9sQktIOTlFNitLRnk0N05YMHZkK3BoaFNwa1FVRkowb0J0N0Jk?=
 =?utf-8?B?dGVTSG52S1RLRUxHYlVGRkFKcXkvTzZUS2tpai9XMHc4R2ZBWU1RR1VPNlV1?=
 =?utf-8?B?V0xOeGc4dlBRWklVVldITm05WTczKzRMei9PR2FaTTNCMTJScjUvQlpmWU5L?=
 =?utf-8?B?YmovWXYreVZpdHl2dFBtalNVb3ZvVFovRXNJSmZvdm8veVRkMEU4OWMwR1Q5?=
 =?utf-8?B?UzUyV1dTNjNwL0pWV0N1aEx0UkdLYmUzeUdBTUNmNHhjWGNNRXJhUS82eEdL?=
 =?utf-8?B?Um83WE9KSzNKVVU0TnRlZUMxWGtIRktOcVE4YUIyQlpIakI5K2JSRFZhN3Z0?=
 =?utf-8?B?NmcwVnkrVTcwdlEwRFRnYVlOL1preVRaNWhMRi94RlNnWWM3SmZ6NjMzbWcw?=
 =?utf-8?B?U05RNHVsN2UxMnZQeVRieENMRFBoTzdvMlk4WFVkbnJuZS9SSkd0N3U0S3hC?=
 =?utf-8?B?RU9ZL211cGtrL2dxSTRxQ1BUZEdUb0tlQmRiTWxWemxEeVpIb0trTTVNQnpp?=
 =?utf-8?B?RWVlNTVCTzA2VUdCS1hGdE9yOXZuWHJCc2hYd3JzTmlsbnFYVXFFTTdCSHNz?=
 =?utf-8?B?TGYyaUlzM2dpYmtuR1ZEamljWWNiQ2I2c2dTR0liUzhTRStHajRuclJnZHF0?=
 =?utf-8?B?VFZXS3FabGt1azd1TytEZ0lzNXEyQWFBTXRINW9MOXBRS3hPV0J4SnNNVUJH?=
 =?utf-8?B?WER4a3dGM3F5d0luWUVQVFN5RUJNdnUwMnErWnpMMXI3eGFnYVpTckMwUk9L?=
 =?utf-8?B?eUxJR3dKS0RHdWtDa2VJMTB2cjJkclUxZldkTEtrZ0FkSHBaYTNYckszZHVh?=
 =?utf-8?B?UXNEWDNTWkZrVlhkdlJ4SFNodnJGVlJYYU5HWW9EOFNLczNjRUxSSjJRd2hh?=
 =?utf-8?B?K05rakt2SUNmeUVzN2g2QStJU3FJKzJtblRhV0o5cUs5OGNZZnlHL1NBeDJE?=
 =?utf-8?B?OVFYK3lsajUwb200ak42YTA5czZkQk5rYVR6ZWhEQTFqYmtacUhnZGp2Qlkz?=
 =?utf-8?B?T1hScEY5QmgrcjhRaFk2T3hlVlQzM0loYVBrL3RETXU3MExrT3M2UTRucWVp?=
 =?utf-8?B?NjhyZXFQVlp2Z0ZSdlB5d2FJN3BMeWF5OGdTd0I5U2VmdnJlMjV0MjZZVHNW?=
 =?utf-8?B?akNqTDJSeStva3RGT2Y1WHp1TFUyT0w3QjBBQUo0ZFV3ZDg4dEt1NzhpcDls?=
 =?utf-8?B?S3cvejExaTZuSGZYN25vRjZZcm1pTDBORXFjRWdESjVHM2JEUEFrckRrTGZK?=
 =?utf-8?B?ZHdlWjRkZzdZWXNIRGVpNW9GMnhoMWU0ODl0cXBCNjhCdXNDc3FlMVA3OWJ3?=
 =?utf-8?B?SjVSMHZ0TnJPcUY0eHNQZS95d0h2aFJUM0ZSWlkzdkNlb1FCR1cvSW5EeWRR?=
 =?utf-8?B?NndxUkIvQXBCcUt4aWxnR1Zpbm5kZTN3QnZWZ0FUSU51aEIxM0U1di95V2dy?=
 =?utf-8?B?cjFlcHBreWlkL3dHckNscklnV09yem1YbDJCMzl3dTlGTndGN05ibFJaZGQw?=
 =?utf-8?B?Ynk1MnlkQ3JtSUQ0WENWSjNUbThCcTdsRytoZE4rRjFVcEw0UENpOVd6YjF6?=
 =?utf-8?B?QVQyZFhqZ2V1MGU1Q2JrR2RIK21adnFyTEU2MjRMY3VvUGtRanEyUndVd3lY?=
 =?utf-8?B?SVBHcjk3Z3FseXc3dUM1NlhLYmUrdTFTUk1nSlQ3aTllZ3pNN2liYTB6ZURV?=
 =?utf-8?B?UGQ1NHFieGhlSnNHYnB1cTBIVG9VSWRjT0NKMElsQXRTcHh1RmMxTlNQbEhi?=
 =?utf-8?B?SzFyamgxaFExY0tXa2prTUVlS1piVndFV0hFbzFEOWNuRVhheGd1TUdxUDB2?=
 =?utf-8?B?NElWbFJ6d1V6N2IyTU10RTUrTXhjeTJTRUdMWmxzYzQ1ck1heXJEZ1ZLRFFq?=
 =?utf-8?B?RmpFcUY4ZmVEVHJELy8vTmluRWpuaklyYmxmK1JudTM0cVBUNjFKY2VvYUda?=
 =?utf-8?B?SERzbUt0bS9GS0pkbGl4RTM0REdGd2h6emFsMVNJbnNMOU4xbUI3d0lBU3RC?=
 =?utf-8?B?VlRBS2VwNDBOSFhJUjVEdFVUcS8vWWhOT2xKUFpiRVdwcnZPd3FSTG1ZemRy?=
 =?utf-8?B?QVRBUWRZbTg4MUtXeTZ2WEVGcGQxa2twVHhDYXZKUnBNNGozdUlQVU91RjJy?=
 =?utf-8?B?TkRNNWtNRmErRmJZdmhCUHB0UWd4QUpDekZNbFllS0M0WFdBSVhoUStxNXV2?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?K3o3bDZMaWI0ZnZhSmNENUhpL1V2Tlk1MnpMajhNeUwzc3JORnA4Z1hIVTda?=
 =?utf-8?B?N3laRE1HNFUxVWtadU53T1J2aDB2TWY0bUpnSFBYZkZneWVsR3UxeHZuNjRB?=
 =?utf-8?B?YVlaZFdTK09WdlFBbnp6MzdWQXNWNlVXRmhCcTF2SjNkaTNQbHFtNWVMUjNV?=
 =?utf-8?B?ZnNodVRuTU5aaFBkczlXdjBNaFRtaTZuZEg1OGgwSkVUQXIyYWloazNSbFoz?=
 =?utf-8?B?WGZBdHBKLzVaOGptL2xUL0FTY3MrSzk1dDF1N3lLY1lzT09zbHVmSW9zaUtp?=
 =?utf-8?B?dW1FdEthSHp3OEsxTUlibVhCMCs3VFNTU0NkTUJPcjhuYTdRMFJqT2dRcVF2?=
 =?utf-8?B?VDdMQStnRERtdmhIMlc5d2dXSHYyd1pmdHdrcmZydElyR1VlaGNVMGIyK3Jl?=
 =?utf-8?B?eFF2bS9BTndldkdGQktONkJERnh1MFE4aUpHT2xUQ2hUS0pQQnFNcm5JS3NJ?=
 =?utf-8?B?UzVjdGZ2Mk03eVliS09NSm5sZE1mVlF5M2lYNVpkdkpGZ0dFRGJscU9VL2M5?=
 =?utf-8?B?dFRPYW1EWitTOFEzZjRCOVNqZkVmMFQwYk5tOTZqWm1vZ0RnaW9aSXlFTFVi?=
 =?utf-8?B?Y0lLMzdidXkvNmw1aW9SK2RFY2hBTHlXODF3TkpHcHMyejl5M3E4VjlBNm5s?=
 =?utf-8?B?Y0EzNGZoTGxQQ3UyQWo1NHh6NmwyRSsrZkFGbmJUa1NaNHNuTGluUEh6UkZi?=
 =?utf-8?B?akZSQlppclhUeFNhR3ZkU3RXQUVnYzAyK2F5T2NHNTREVndaV3YvUnB2M3Fs?=
 =?utf-8?B?amZTUEZZdTN1U2ZhbFJ1SmRkZW50TW1DUTdUd2xDUEpNNkpESW5nTTM0M25V?=
 =?utf-8?B?WVF4akl1VjFBdXZOQjR6d3FUK2xoNW1JTTVEbEtpLzNWUFFhTXZCZUswcXcr?=
 =?utf-8?B?UXJsMkFEK0VlWEdQdUdiMUtQa2FkUlFuOXNtV1ZFRmszRTIwdnRuZXRPNWxB?=
 =?utf-8?B?THdOaDVVdUszU3NGbXlMVjFkWVVUNjZ5NUQzVGEvK09FbXB5UGlnYVlid3VL?=
 =?utf-8?B?RzBtTGtSNW53VktObVorbUpHY296Uy9kOEI2TjRiODc4U0JjaGlEWDE4Z3Qy?=
 =?utf-8?B?bWNtOCtzZmgrZDd1Nk1PaHBXUjZ6ZDZhZE9nYVBJbnpRYXZDc1F5TWJwL2Ns?=
 =?utf-8?B?SVE4TDlzU2l4azRGTEFtSWxBQmpGVFphdDVnSkJISzVHaTNaUjN3YzI0eGt2?=
 =?utf-8?B?ZmwrNVhndXQxaWtlNTVTWHpGSHlrdWo2bDhRM3RwR0hNSmtLM1VWcC9aSTd6?=
 =?utf-8?B?ZkJIQndWSmdmc3NjY21JUVFLeHZ3REI4THN0Zm1NaGRON3QvNEpWZGdmZEho?=
 =?utf-8?B?eE9ZOFYxckdQOE1MM2taZE5WYU9KYXNCYXFxL3FST2ZpaWwraXNnTDZNeTM2?=
 =?utf-8?B?L3BrWWJraUxlakNCeXdkSkN6bmVwNXZabnZaaitQL3F1U1MzUTd5SEJTR0Qw?=
 =?utf-8?Q?SgZ+4XKi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5670f299-c06d-4ac4-1c79-08db92087019
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 20:55:14.3967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8C2kirFe1fZp7KdLTRv4tB8yDiBkli5u+nfjqN5N6myu/cJnFMi2LsmlLfhi3a5tERRjOmfZOIwUyNRWBMigbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_15,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310190
X-Proofpoint-GUID: I4TP29KGHgjeOm5tNKcHDtDLOu94daKo
X-Proofpoint-ORIG-GUID: I4TP29KGHgjeOm5tNKcHDtDLOu94daKo
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230731 08:55]:
>=20
>=20
> =E5=9C=A8 2023/7/27 00:39, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
> > > Add myself as co-maintainer for maple tree. I would like to assist
> > > Liam R. Howlett in maintaining maple tree. I will continue to contrib=
ute
> > > to the development of maple tree in the future.
> >=20
> > Sorry, but no.
> >=20
> > I appreciate the patches, bug fixes, and code review but there is no
> > need for another maintainer for the tree at this time.

> So can I add a reviewer here? This is convenient for me to review the
> code and know the problems reported from the community. Usually I can't
> receive maple tree issues reported by the community. It has no effect on
> your maintenance of it.

Although you are on the path to becoming a reviewer in the MAINTAINERS
file, that file is not a mailing list and shouldn't be treated as such.

You should receive all maple tree issues reported by the community by
using the mailing lists.

You do not need to have an entry in that file to review patches and to
be added as a reviewer of a particular patch; just keep doing what you
have done and send out R-b responses.

I am happy to get reviews by you and will be sure to pick up any R-b
from you for the commits between revisions.  Please also review other
peoples patches on the mailing lists.

Thanks,
Liam

> >=20
> > >=20
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > ---
> > >   MAINTAINERS | 1 +
> > >   1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index ddc71b815791..8cfedd492509 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -12526,6 +12526,7 @@ F:	net/mctp/
> > >   MAPLE TREE
> > >   M:	Liam R. Howlett <Liam.Howlett@oracle.com>
> > > +M:	Peng Zhang <zhangpeng.00@bytedance.com>
> > >   L:	linux-mm@kvack.org
> > >   S:	Supported
> > >   F:	Documentation/core-api/maple_tree.rst
> > > --=20
> > > 2.20.1
> > >=20
