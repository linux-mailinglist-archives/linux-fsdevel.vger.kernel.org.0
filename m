Return-Path: <linux-fsdevel+bounces-4767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DEB8036E8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 15:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343511C20361
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F84228DC5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RmsV/a50";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FbJ1w5Qx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBBE95;
	Mon,  4 Dec 2023 05:14:43 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4D0vNR017820;
	Mon, 4 Dec 2023 13:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=u1Me0c0pDT1iHHvXjJKtxlWtoZZ8ms6sKrr84vSGuTM=;
 b=RmsV/a50L2D6iayPDKXeMiDnDn8dRxCb3RmQwTnrUYpIUr+N989DK5+9SQThMCkdNVMY
 axorSmp7HvRU/3ZeAAw0HqaQYDS9zbZgjzNpKe7C7/o4Dgx4SRwtjzGVg8iRWWtoV126
 MoZptoDR2V4izgf7pWu0lyDXyUNJdgzPA/OZfz378Sq8YBHNBBNUElJFyPay8Sowpotp
 TO2ZRfGdJamNI6MhE21dKmqwJAGXE4ZIGH6YTQmt58zsBObhABgXOexGdGpDz4Z4kZZz
 YXrJ6jYQa3KdGSJCEjrwON65Bpuke3cVKgIdkfiPvA7Y43jbiYcKD57VYlI6oRPNUdIV 6w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usf9f02k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 13:14:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4BcVS6006056;
	Mon, 4 Dec 2023 13:14:18 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu15j3vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 13:14:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fX7W+gm1O/dgxrMY2qPVAN8e5kZKZThVbzcAAwCyt0YgsztzLTggUS/DR/rOcHZ2LoMieYsgbOXxwHrma4s2H506hdzDMae+D7+1C7bCNgoKrsJJWV1QrHoVjXprYg3nNfAE0T2L5as0Uto+Nz9/eiCEW0btIcohENdsPVBWypGg/OJkF2oFcLqFgPTn4W5JDZEpoEt185G+p4UrNFzq6Z5JckblZ3+ZGgVPqahYllTDhUImVNIJg1tcrFlJzb+6YYW954kuOoK/D9h2NIFOzti7BivUfNxSwrJBdTFxNE4TdayzcInbsah87gcw1qxrj8MN3qf12E67DQoXVBj9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1Me0c0pDT1iHHvXjJKtxlWtoZZ8ms6sKrr84vSGuTM=;
 b=gaKXVOx2x8Uuu7u8UJdxOE0pTlVXMM58SBne5HYOpheR7rjV87HEVs+rIX4DUQNAv+wgyqgRPpnEAyHE/YI+ePO8uhdbhQAhNA1PtoCDYrFoPqhEtLpEIQAQC1SWOixpGe3Qtq8SSihz4LubnIC4UmxtR8lAm+YsibRZbZfsKRQ+5lxwWGOPLzlbYYwndKCxJthVZ+vnxj4yTaPMPXzH1DWiN+dAQvxfiVX9J7soTGhGHlM+5wN4dyfqY98GICFPgASN7xQP/MVJuuTJV7WHycnmwAl3NUHnDEzQrsiJYK/Kwzhr+JfcVAxeDJk9jM/8yP8iLA+Gw3Ike2eh5/Aajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1Me0c0pDT1iHHvXjJKtxlWtoZZ8ms6sKrr84vSGuTM=;
 b=FbJ1w5Qx+VJtFhBGwTIACMVKS+sddDTh/QSdOPhHTxO2gtSsHdCCwx3FwWhyutOnp960D91tIRqED75X6a5FL9+kCMG5v9Ec6UK38OwG/YDJ9X1Ez0EAgjtzJl5dqJ6m5Im4gpo5bCp6Z5pQPjBQyYJz3CGhvi36xwOIx+jCVDk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5855.namprd10.prod.outlook.com (2603:10b6:510:13f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 13:14:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 13:14:09 +0000
Message-ID: <bd639010-2ad7-4379-ba0a-64b5f6ebec41@oracle.com>
Date: Mon, 4 Dec 2023 13:13:55 +0000
User-Agent: Mozilla Thunderbird
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
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZW3DracIEH7uTyEA@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e4349b-2d7f-4349-1608-08dbf4cae685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tleAg7ML2Pr43bxARln1SCZPvjrEgx6D6hCVirQ57noXbMM0SO09EP0F5Gf4PebHvisLYDS8CjOR2MvfwkbCf3ESkLLrj8b/l9k3K7GqmO8y+tDjrg0oj/wrHkiRKl7G+99TnjBkXDNfLUcCn5112/L3HvgZ2T+f8fKOv2KBvRf/9sGafXZ/GazaPtmWBwi7zq49uQ4hxffAGmP/+rRDjc6ST5v4vec5B7grIbtn8z+/wVJUrILzP4rVszgclgSNW9IgnLiyiCnAyuvxrl4ClbOEx6t0uhl+8r5Bh6vEskjfpGMvjK8N0z90AEuFXuErUSYfftAAq4X4vY+Y4ZMsNq0Khd7DvMBYy5Lv73nd2xnxjQDZ93aYFCmtN6jAJPKIA4kWfWX3wu7uc2HK97EIpyOoutgq7Cn1ifcC3pJq+yqO0tQ4B68avUYWvxpBSZARsHJ+D+fvdNLzrvl58CdUK/tBMnj15nDgr0th7D8qi+x4WJXJJcWuO5VIZwGgEYoy5S72L/R6CRftcB6DftnOLQtD4M6bdmfq6OM1JVO+gjQ30+zW67vBzMns6IKhZUKriF4oEmJSsR9aQOi7t3b2SWIodxLSp3WfL+a6VgR9HdjgieRP24MNm9LJK3mYmaqQBmykG0NQvhwGObgEBjdFkA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41300700001)(31686004)(6666004)(31696002)(86362001)(7416002)(5660300002)(2906002)(83380400001)(66476007)(4326008)(8676002)(66946007)(8936002)(36756003)(316002)(66556008)(2616005)(6506007)(36916002)(478600001)(6486002)(6512007)(26005)(38100700002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eDM1bFJvKzNnTXRlQjB6NTJPNjh2NUxZdlRueDYwQVJYcTkxbktxYmdWcTI1?=
 =?utf-8?B?VTdxOFcrTFZ4WW5HV0dQU0FIekdHZ1p3S2MxclN0WnB2Rkl4bDJFby9ZUWR3?=
 =?utf-8?B?dDlrTkZUTWpqcUNlRllzM2tWaHlWKzhGMjRrSTgwODZaWmhsdC92N1NiZVBO?=
 =?utf-8?B?aGpKUEwyNmNscVErKzFnb29hN0JTMGJ6aWxkOVZQSkxVWisxdllQbElZb0dY?=
 =?utf-8?B?U01hc3BUZjBITzl6VHZXSUI5TW5KL0NXWGt4dGU5a0l4SFhJUTFOM1R1Rm1G?=
 =?utf-8?B?Y2dxYUtHcmcrN1laenlXVjcvMkRCS2FNN2s3azJyY29wciswRFo2UmFOWFRY?=
 =?utf-8?B?VjZIYU16VnNMUWJsaUtFbVhGSWwvekVpT2RoQnFiNkYvTmFtY2tJTmsvTkdC?=
 =?utf-8?B?UThtQnpiQUluZllhYVFremxRaUtoZWNtSW44ZW1majFNaVd3ZVRGUFU0MEhP?=
 =?utf-8?B?aVFuWGV3cXpkY1hWMEhyOHJOaWIxSkpseGtRMElnQ3pOYW9DQ3NrNm5ST295?=
 =?utf-8?B?OTU0UUJhNlBxS2FXMmNidXJkTFhrMGlCUmtVVmZYdGp6djVzYzYyUGd3cHNm?=
 =?utf-8?B?eW0yN0hlTnRtNlJLL1lDSWVwV0NBeVNqWjZaTHNxaUNZTTdsMytVbWcvZkor?=
 =?utf-8?B?aVdPYm94TmpaMzNhR25jcVptSG40T3NxRUJiWVpuUWFRNjkvaU8xamZNQjQz?=
 =?utf-8?B?OFY3cStER2NKTmhXbFJBcnBTK3o0L2JscGhUM3NFcCtFczRZNkc5SnVYR2hV?=
 =?utf-8?B?UXZsNVZUSjVUQ0NEK0hYNkJHSmJoRUEzOGVPMTAxSVdCcCtQd213KzJ6RnJy?=
 =?utf-8?B?MzBrTXFpKytBMm9YOTAwVkxtd3JramlTWDM1UlVGNFFIK1lrN05zb0dsYXRt?=
 =?utf-8?B?WW9aV1hWbTNOMXFtM1hibjBkWTFRQ3dZdkZYRThCZWZETnBnY2xTMHFTSnd0?=
 =?utf-8?B?cmoxS2IzSk1UdlpHdTZNNkE5SERzQXdvd1M3ZnVyZ2ZQaUJ1bU9wUWFlbTJi?=
 =?utf-8?B?eE51YTdJSitSeGtWQTB2a3F4QzNNR1VCV2JLUkREZ0NNNDhiK2FRSjZodEJB?=
 =?utf-8?B?S0tjRGRheWZMUnliQkI2SlRtTnNTbnZKalV3eXJMOFc2TmtZQUFKT0pwWjMx?=
 =?utf-8?B?cWpPZ3Z4NFV3TjRHZGFXWG1QajRBWGNsWTB4aytOZ2g5VFY4dklQaFFrZHFP?=
 =?utf-8?B?S0RxaG5GNGd5VlVadHZFdmgrU3h3RGlha05YQS9OYjBDcEY2bVdsQ0dwUmVB?=
 =?utf-8?B?STNVbEZFVUdMbFVGL1hMYU5WT3VYdFZzSVBxV3Q3ZU1tdnNOdDFlZE9LRXY0?=
 =?utf-8?B?UjJMUlI3UjFUUEY3OUE4clFBVU12aEdSRFA4ZDIwMkswd2dwenJqZTRPT21K?=
 =?utf-8?B?V2cyaUEvNUJ6bEdka2lTUldzb1B0cms4U2tKSVJDSVlsaVRKUUFMZ0N6SHN2?=
 =?utf-8?B?eUFjU3hTNGR1OWpxQ1YzMndmdlJZNFJoWWF1N0ZlMmlpYnN0eTFJRnYwOFNa?=
 =?utf-8?B?MnNvcWNkRkdqb2Q0WGNyNnhKSG90RVRUOE56Qmprd09qMWFCWDBkL1F4VjRB?=
 =?utf-8?B?SUZuclFmRjBGZUFuWGJrcmhXcFExMHRMQnNBakNkVWdBSjFSM0VyZ0xoWWFi?=
 =?utf-8?B?c1RiQW8rNWlZZHRNS1kwdjFzL2VPcVZMcWw1YXlTTnY4ejJ1aWRzaG43NHI2?=
 =?utf-8?B?S0U1QmZuVWJFRXJMckl1NTdUSUhNL1p4U2JpUkRRWVM4UDFuTXlhSjlhN24x?=
 =?utf-8?B?SHl0TCtFSEtJUkhLTXdPOGtmZkxJb0JUVlN6alNTS3JISXVZRVZsZnJvVnB2?=
 =?utf-8?B?ZThsRjBqdXlaWjFGSGVWcUt4VURHWFd6dXR3ZWluVDlUWVJhR3RCY0t3TFF6?=
 =?utf-8?B?VTNIaFBkUXE3ODlGbk00dlVRVGFTVmlwK0ZjVXhkWTNKQnYrQkhKOXZyd1k0?=
 =?utf-8?B?cnI1RE41UUN5ZmRwZmowTWFXOCtDdUg5M09ESDBGSUd5bWM3K3JRdm4rRk40?=
 =?utf-8?B?UjdlVmdzazN2dTgwM0lSZHY2Y0xoMzJ1elRSeW9TTmR0TS9kMnRNc0V0UjN2?=
 =?utf-8?B?SnpyWHhhd1k5NkdNN1FaZW5IOE54UTZ4M2dENVFtazVYRkI4RHNiRUs0dzRj?=
 =?utf-8?Q?CyqElXZUW+OkQ2O3k/7zxl/DB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?QkJxNEw4ZzVuQjFvN1grL3lYK0FRZUlGNWxkMVBaaVliNGcxV2M5R09weVQr?=
 =?utf-8?B?Sk1lWm1EQjhJQjZvTzkrMk82bHVxYW5HMys0MnBPdDdUVjgxRktBSXRFcWRu?=
 =?utf-8?B?REJnbFNaOFVyS2NUdmYxbnd3am80dWN2SDBuVUtjaHNabDkxUVZBYWMvM2kz?=
 =?utf-8?B?L0wwSjlscm5BS1NaYWlxWGpwY0piRnYrQURxeExhWnl5K0FyUVllSnRkZ1Fk?=
 =?utf-8?B?RzZjUi92V3hXRHVVNnFVSTc0cnFBSmRYeVdIOFROSEZQTXJXNnQ5bC92ZGxo?=
 =?utf-8?B?M2Rmemg1M3RYWlloaFJ5NlZKakZvbi9QK1I3dDRBWmY4Vnc2WWZzQ3p0clVu?=
 =?utf-8?B?SFdTbUJ6Q1ZyMVlvTFJZM1gwam9lTmk2QUIycXV0QzZ3M2Q0cEp1R2swbVB0?=
 =?utf-8?B?Qy9vT2pXSG1EY0pTMVFmSG8vOVVKZ0o1QjQraDVWdkhEM3AxL01ZOVJaWFln?=
 =?utf-8?B?TXI4a3grTGZIVDVuUzAwK1hmUEJaUkhvYmxIZ0V2V25TVy90T2xjWnN6Q3FT?=
 =?utf-8?B?VklJdVJ4WDNETEFuY1pnQlNES2NVRllIZFZVMk1IcFBsdDM0a0lrSGVmK0ky?=
 =?utf-8?B?Z0pGajBpMFgvNXVEUDN2OFNWZWYyOURQSk0zVW41SW05Q3pPTzdhajhZK2dJ?=
 =?utf-8?B?N3E0dzFqdzdQbFlSVDVnT3VJRTMreU44b0xZNkVVbndKdEdTY0RBSEoydWhw?=
 =?utf-8?B?NTU4SXdLTTJQUXVlclBhWlorcHNYZ2ZrRlZPeHJaQW1Ja3Vkc0VxRnd5SjlP?=
 =?utf-8?B?N1grVGxJQ0IvWFowVXE3Uzk4K0F2MUFoWUpXVGdhWEpNTjFKV3BtSEE3cXJi?=
 =?utf-8?B?VHFzdTBseFRTdHNpYW1JamxTR1VLeE5RV0lKMDlyVWNJWkFqcjNJekRBUjMy?=
 =?utf-8?B?ekpaTjhvZUljYkpKOFZXWkZmc1IydUprZDlZNm1IMHovVS8zdnlVeVFsejhO?=
 =?utf-8?B?UEJLZkhDQW1tNlZEM3RRSGgrVVdEWkNmMW5GdDlPUXkrWElRekNhRi9YeHdp?=
 =?utf-8?B?NG0wMU5kQSt1TmhiOEREWUF5TklCTXBoV1FBTE5nUyt5dFpWREFSVGlKNUls?=
 =?utf-8?B?VlhJOW50MUpUeGpYK1NJUnl0VHR2eFQ3YnpjMnRWVzBaempCU0Mrb3dKTXVq?=
 =?utf-8?B?TWZqWjlLckxGQjJPblp4YnVQbkRRbjJkaUdjd0RnZFBlb2NQTEVjSjhNVkRL?=
 =?utf-8?B?NThWcThhZUQxVXhPaVY3cHA5eVhwbnFkUlllVFNPSmVKb092K0dvZGdzYUpi?=
 =?utf-8?B?bjdSOUpnM2FrWHp2UUxTY1pMSUNHU1VrdzB3V0ZtSEVOaHZka3dWSHN5WlF1?=
 =?utf-8?B?elVzZjZ5L0NJS2NUVE51S0lWTTJsaVN3eFJaR2wwS2NZajYvd2M3bXFUdTQ3?=
 =?utf-8?B?M1M3cFFxTE83NDgrNmQ3UkowQ1FJOXhNeVlCM1ZjTDROOTBBaUhCdVNNUHY5?=
 =?utf-8?B?cGVjNzNEVkx6VW5HWXFrdHRsNkpzUFZ3RmFLT293PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e4349b-2d7f-4349-1608-08dbf4cae685
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 13:14:09.4242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIXlHHz6wMqETQ2kVFlZ6c8qCzaOkLJi/2lC6NcQQEHpSsmwdsuZr9mAcCy7q/zLxJyI0YqH7ez7bhykqp6UVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_11,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040099
X-Proofpoint-GUID: elMMzkmnQdMeBEHJ9Jdlda51XxvUS9jm
X-Proofpoint-ORIG-GUID: elMMzkmnQdMeBEHJ9Jdlda51XxvUS9jm


>>
>> I added this here (as opposed to the caller), as I was not really worried
>> about speeding up the failure path. Are you saying to call even earlier in
>> submission path?
> atomic_write_unit_min is one hardware property, and it should be checked
> in blk_queue_atomic_write_unit_min_sectors() from beginning, then you
> can avoid this check every other where.

ok, but we still need to ensure in the submission path that the block 
device actually supports atomic writes - this was the initial check.

> 
>>>> +	if (pos % atomic_write_unit_min_bytes)
>>>> +		return false;
>>>> +	if (iov_iter_count(iter) % atomic_write_unit_min_bytes)
>>>> +		return false;
>>>> +	if (!is_power_of_2(iov_iter_count(iter)))
>>>> +		return false;
>>>> +	if (iov_iter_count(iter) > atomic_write_unit_max_bytes)
>>>> +		return false;
>>>> +	if (pos % iov_iter_count(iter))
>>>> +		return false;
>>> I am a bit confused about relation between atomic_write_unit_max_bytes and
>>> atomic_write_max_bytes.
>> I think that naming could be improved. Or even just drop merging (and
>> atomic_write_max_bytes concept) until we show it to improve performance.
>>
>> So generally atomic_write_unit_max_bytes will be same as
>> atomic_write_max_bytes, however it could be different if:
>> a. request queue nr hw segments or other request queue limits needs to
>> restrict atomic_write_unit_max_bytes
>> b. atomic_write_unit_max_bytes does not need to be a power-of-2 and
>> atomic_write_max_bytes does. So essentially:
>> atomic_write_unit_max_bytes = rounddown_pow_of_2(atomic_write_max_bytes)
>>
> plug merge often improves sequential IO perf, so if the hardware supports
> this way, I think 'atomic_write_max_bytes' should be supported from the
> beginning, such as:
> 
> - user space submits sequential N * (4k, 8k, 16k, ...) atomic writes, all can
> be merged to single IO request, which is issued to driver.
> 
> Or
> 
> - user space submits sequential 4k, 4k, 8k, 16K, 32k, 64k atomic writes, all can
> be merged to single IO request, which is issued to driver.

Right, we do expect userspace to use a fixed block size, but we give 
scope in the API to use variable size.

> 
> The hardware should recognize unit size by start LBA, and check if length is
> valid, so probably the interface might be relaxed to:
> 
> 1) start lba is unit aligned, and this unit is in the supported unit
> range(power_2 in [unit_min, unit_max])
> 
> 2) length needs to be:
> 
> - N * this_unit_size
> - <= atomic_write_max_bytes

Please note that we also need to consider:
- any atomic write boundary (from NVMe)
- virt boundary (from NVMe)

And, as I mentioned elsewhere, I am still not 100% comfortable that we 
don't pay attention to regular max_sectors_kb...

> 
> 
>>> Here the max IO length is limited to be <= atomic_write_unit_max_bytes,
>>> so looks userspace can only submit IO with write-atomic-unit naturally
>>> aligned IO(such as, 4k, 8k, 16k, 32k, ...),
>> correct
>>
>>> but these user IOs are
>>> allowed to be merged to big one if naturally alignment is respected and
>>> the merged IO size is <= atomic_write_max_bytes.
>> correct, but the resultant merged IO does not have have to be naturally
>> aligned.
>>
>>> Is my understanding right?
>> Yes, but...
>>
>>> If yes, I'd suggest to document the point,
>>> and the last two checks could be change to:
>>>
>>> 	/* naturally aligned */
>>> 	if (pos % iov_iter_count(iter))
>>> 		return false;
>>>
>>> 	if (iov_iter_count(iter) > atomic_write_max_bytes)
>>> 		return false;
>> .. we would not be merging at this point as this is just IO submission to
>> the block layer, so atomic_write_max_bytes does not come into play yet. If
>> you check patch 7/21, you will see that we limit IO size to
>> atomic_write_max_bytes, which is relevant merging.
> I know the motivation of atomic_write_max_bytes, and now I am wondering
> atomic_write_max_bytes may be exported to userspace for the sake of
> atomic write performance.

It is available from sysfs for the request queue, but in an earlier 
series Dave Chinner suggested doing more to expose to the application 
programmer. So here that would mean a statx member. I'm still not 
sure... it just didn't seem like a detail which the user would need to 
know or be able to do much with.

Thanks,
John

