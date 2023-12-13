Return-Path: <linux-fsdevel+bounces-5822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDF8810D36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 10:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04CC1C20AF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 09:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861A120325;
	Wed, 13 Dec 2023 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fTNzwVxB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sE/J+g99"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AADB7;
	Wed, 13 Dec 2023 01:18:32 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD7ELcN004118;
	Wed, 13 Dec 2023 09:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=bd/eppqzQobGUowlK5NSE/My+NzlMbKyE6r/OASWIfQ=;
 b=fTNzwVxBLi/iLaKlb+jIx5jWdtU6nPWdOJoZ/64i/ajDkS83kFwY3xpKkgUyflG086vy
 7t09FyhnBMcqX51r5IrVSmrMF0A3N5qMStG73HouAAPobxwiwpRE7n5wid8R7WFjomlW
 zRSwnefY/x+hEkXNI9jbiYWIQMax+YiirvK0k4Is+qRaSGybM0p6gxPreYAFKuNVvYBt
 smaxIsgdQ1veXbMvbdwiQfcLMUZy+asI5pJZ8KPVJbMp5yKofbNAAndNBgBcvGSfjvSz
 GSL7IxkFTQPgtqVVYV5No62YXj1isKr2s/D4Qv4Sd6d3uYM8DfN+gUMj5rSAK1xboIFY rQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uveu27nx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 09:18:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD8L1ls003153;
	Wed, 13 Dec 2023 09:18:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep7ywvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 09:18:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MetWVtmO1kusWKgQ1ibBVryV8NOmxoWwcDe9Xu7jsAjcrWbYnAq9Gv7/5EMyvsOB4v/8oDKa8K7MQHMPnToGhmp7kNvszAgr/BoFWKjVBJq1yQ2xxdoGkR6P7ysV39ig78HssKhEYiw4rSlQqtCrRM4rDc7smUxZM0FNkSgpSYFSB55oEIY6FJJx+7nHX2URIemAJrfddBbeGkPTvXl2AapmX//KLg8t/I1F5Ksd+6tCUanRkzDCshW3Wdebynw1jZ6wnHsxTJHskMwMEftQTGj4tATQQJeysLiq5v6IIYQdpgO0XoROgtMrFzi24YcgwUPWX+5No9vKYPINIZ56kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bd/eppqzQobGUowlK5NSE/My+NzlMbKyE6r/OASWIfQ=;
 b=FJnBgGbewc6GNFr4NYdAG/AUpFNnn4uisxZbkX9BnJummOQHozxnuBZodOcjjqgoeB196BQ/JdNKmDXhKAqiX1B/mEh/as8jjPjkCnXI5kGLhQeHDmPHxSu/ItytSEvF702L3Afh9hnOWlTya+OJGsj/Zl5y9y0kJpqVoUg+lUp2Lmv7MoLpZqA1XBIEmv8RVXVh08KK0ETbnQJWSTRYQ4m4OI8VmHyk4v93MRWQsZqcibmN5fj7Y7Z+TfSyMmLRtmstaeCNjU5Rir7JWzs11zmsNsp1QQ707eD9aPItdRf+rgXI1qzFsvSJNf0IXpzOUAM/XrZ3mb9jdQhtp4bb1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bd/eppqzQobGUowlK5NSE/My+NzlMbKyE6r/OASWIfQ=;
 b=sE/J+g99uWYMlq2nD1HrzlYBs75gIBTMgiTfRUoeIDboUo74dSxJktS6vfct9hlvlp67weKUYMHCRNabUbSr4iRJ0tarEKXAE3l/g8kJ6LO6Vb+xshj8quLrLgLBOi9VTRcowRI4rINKjdQW9CV+Doq995TJfhHZAz8XjEHonSs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4661.namprd10.prod.outlook.com (2603:10b6:510:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:17:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:17:56 +0000
Message-ID: <23367b48-83c0-4f7d-b75d-c8980b05f3e8@oracle.com>
Date: Wed, 13 Dec 2023 09:17:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/7] ext4: Allocator changes for atomic write support with
 DIO
Content-Language: en-US
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <8c06c139-f994-442b-925e-e177ef2c5adb@oracle.com>
 <ZW3WZ6prrdsPc55Z@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <de90e79b-83f2-428f-bac6-0754708aa4a8@oracle.com>
 <ZXbqVs0TdoDcJ352@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <c4cf3924-f67d-4f04-8460-054dbad70b93@oracle.com>
 <ZXlIXWIqP9xipYzL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZXlIXWIqP9xipYzL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0580.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4661:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb4d939-3e17-416a-3101-08dbfbbc649d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MX5UNxVbCMA62CrlQER+L4BgSc/eDhlE0e76RoAKRAfo9Zs/aHn4xbtgM2YEai+b/epnyv6V7mLf1Wm1ERZ9iyTtoCjZBlSYWmBvDSeXaBTAIaJAjqJK64FQk4CL08aKFezjVCHlqo3unLZD+DGAT37ZWrUd4EQIFCEkNgGRWVI6lHVErtjEVFcwU8Etj6R7px0HTFqa9NXU78SYK5K6UYHQpIur68o1BAanm9SKmhTkHPBf7IFfHYwcSiOwA9rECeJacUsUh4x8zklQK7Qtxul5l5mQAWirsWSXgHBTP7dStFNebuSMfCtXUG+l9mMDlo66/f3BBAGtkRk0sy4nITX3cucyAOnW0OuLKJyd+mTJdnt3KRHAm7rR/2xHt/h+SBfX9krlUO+EEVkf0kmknLm3pPda2dhWkVtQ/0T0zqn4f0XoObrmuxU789j7R/PP2LpBl5KGG9QPIl20wBkAuKn3Fn9dJ8zsYjY3Tal5IhHmltqvOw2iQankP22l173vERfo6jG8QMqmH3yMOMIHb5XlQ+Nqpm07k66etQm5E6GfzIoMoaatpE+0518COp0fjkuLrnItlBNwDifFVBhJBueY1u2XJbK4KpborP7YcF15hHKItA8NXIyx8ilP3QUiUxABDwy4xpcmgyLcUVa+kqj0JxAY6XTEkYREInRh77X6BSjDuM4s+F68PJM59zL5
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(346002)(376002)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(66946007)(66476007)(54906003)(66556008)(6916009)(31696002)(36756003)(86362001)(38100700002)(83380400001)(26005)(6512007)(2616005)(53546011)(36916002)(6506007)(6486002)(2906002)(316002)(478600001)(6666004)(7416002)(5660300002)(4326008)(8676002)(41300700001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZVVkRXhvTlBmT3M1TC9pd0NoaCtnNUZncnp5cmpSY21XcE1YZmNnV29RM1hr?=
 =?utf-8?B?Z1JvK3Y3b3RuYXBid1F1bUVBcUdpWElRQmlSYWtRU29ybkxJM0h5YzEzbFdY?=
 =?utf-8?B?d2R2d2xCT0xsMnBnbXlyWHNDRTd3YlRiNGtxK3pvbThVblkwOFRtUHZ1Y0hN?=
 =?utf-8?B?dTE2YlRuRk1QY0ZGTDJhRks5dWkvUWpDWVFhaVBBM2tmcGkraGhPWW02eFVY?=
 =?utf-8?B?cWcyNkdwK0cwalNjbVVOMGRXYm1RQXF5V1IxbUwrM2hvUzFad01Oakd6My9i?=
 =?utf-8?B?bE0xRkVIekZveUw5NmxsYUdweXV5NFp5VnZjSTBhU2kxRHFnbzJLY1UyMFdo?=
 =?utf-8?B?L0NUQUV6VkFUemE5QmlqSHVIS0pwcCtlYmVFOGpDbms3UlNPcVNMMVZyYklQ?=
 =?utf-8?B?U0hsYXZyYWRObGtWMExPZnlidWZCT1l2bk0ySlRNd2xPSWxYMmJXNkExWDVR?=
 =?utf-8?B?Yi9yUHIrdnRSTGpRN2QybmFySllUMHZDdmhlM2lsSE1Nem5PNU1FaHF4RmRF?=
 =?utf-8?B?VkMwbFAreHdSMjNaa1g2R040TDdZQ3BiNWg4ejlSVVNCdk5IcFJ6VmRlRmxV?=
 =?utf-8?B?aytxKy94c3VKaGVlemdVUkZUTHNjb2xiRmdmZE5makJkZmZ2WGw5UWFWeENj?=
 =?utf-8?B?eS81ZEJyeVB5ZkFEVURoNFQ3TUJSRjY0OXc1Yk1hdWRtR3BRUWVZQWlyN01N?=
 =?utf-8?B?cG9oU1dMSlo5RVUxd1d1Qjh1dDNGSG9UQS9kckhDcHo2OGNhc0RWdzFEQ0dw?=
 =?utf-8?B?Sy9wTWd4QnR3MlZ4dDBkTjNzbkNDNjVET0pmVlAyS05ibEQ0SUdIcEFIRTBj?=
 =?utf-8?B?Rkk2NlJsS09XSGprNXMzb25PczRHZlNBWlIvc1AwOWltQnlQd1dNSUlYKzhv?=
 =?utf-8?B?NG1hOGRUZ04wQVVMMjlnKzhmRFpJMERtTldGbGpiTHBsQjZuYXJlem1mQ3Nu?=
 =?utf-8?B?RUlsSG9xUjYyS1RXbU1Vd3ZtZllYUHZWZnVMSTFXcGhQQ01SVThYNFltN200?=
 =?utf-8?B?d2ZCcFJOaFVKaTVoRWR1WmFhczNJMWRsN2E1YVd4eWFwcXJmeTk4UWM5QXVh?=
 =?utf-8?B?UE1RR1h5SFlEc1ZwTVUzV0pkaE9PeDJLRysrQzZwWVExTkxEOE9NSGNWb1Jp?=
 =?utf-8?B?N3F3T0RUYmxGMHVHamVTNHVteTN2c1ZTY1kxQy9MMVFGYjdmMWdjZWtBYjls?=
 =?utf-8?B?bUNvejI2N0tIS0x4dUlsd3pJWVlZZ2FXRW5oNnZOMExXSmpab2pPTHV3djhj?=
 =?utf-8?B?bzd3Z29Sa1JlU3RnMXlBSzVoTlV1NGVDWGpoY0hDUU5mWjlvOE5NZTVJNmpN?=
 =?utf-8?B?eExZSy85dXRQQVpSamNLREp3L241TlZKdEZxczZtSWg5N29sL2pwRWdRcDRx?=
 =?utf-8?B?b0dOanBFR2kxSUVqQk04NzdXUVdnem8rUGhYbXdzZ1ZsQWNVMXJMN1R2TVFy?=
 =?utf-8?B?MzF1cGt5RGIyelUzaEMrUllnUENBQ2pqNXlCcmJ0RnJnMmhncEtwN3E0dzhR?=
 =?utf-8?B?WVJRMzQ1eVQrQkZwUnhTOEh2YUl1K2psa1N4ay9ObzRieGhTMmtBd01lYUNx?=
 =?utf-8?B?eGd0ZGkzTmtMbGJrT0tGMEdBNW5ud3VlT0s0Smo1L1pmekluRi9zZ2NJb2RM?=
 =?utf-8?B?Z1htR1p6SU5Hd1AyRzBvYkRvcGVNQTZKNnVZbmxVUGUvVjkvdVloWVNwRTVX?=
 =?utf-8?B?eWtpUGtIM1BBNkhlSGVLK2Y3UXE1SGN5K1daSXpwTzVHN0NPZU82cmh5SGRh?=
 =?utf-8?B?bUxIdU5mTEwyeG5oMHQ0aGN0bkdER1RWY0NoLzlTMkdsV2NTajVoV1J4UE1u?=
 =?utf-8?B?Y05aQVlkV05yekZ5Ky9lYUNLRE5LNmhKckZ5dUJ0eTNXYUMyQ2VGcnBjdEVs?=
 =?utf-8?B?MHNnaVN6VHN2cHhEeFdpWGVtSmlnc09IMy9PRGVYeXFLUUhnRDNTSTRwWkpG?=
 =?utf-8?B?TUNBU2ZXT0ZqSGlXK3FGc2taSDZBYThvWWVlTnlxUlBYQmxqRTlrTTJXVDBl?=
 =?utf-8?B?ejZiYzNMelY3Vmd4K0Z0UGRROGNQNjZQYzMwOU9BbEl3TDVoQUFWSmRtb0My?=
 =?utf-8?B?c3M5TFRFN1BCVlEvVStGanhUVllhMXRDWER5TjNHYmVPamlCT2kxSmcvT04y?=
 =?utf-8?B?NHkzWWIzL3VRVzYrekt2ZnNCNzZwd2hNUUpzQUxaUGtuanE5Yk1scjh4VFdi?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	b4MWe1pIdlKzB4z5fXSycU76y+qdPxu861kDCaE7OpzHIPZOJ9zlbWZ9WDC3HGt/m4eBgKem/8yt4e193LUsitry9Fhyv9DnzLSY3rItxWOob/DDI3J/SjeNfeElntmVYUDq2HaFnbbYT/62MAPZevLc1JpzxSBsch04SJtN8PVPCGmqlIV7DsAmRykogXgpb5Y5IiI+EriD1BuMKksl5FN1iEnjHaeiultPQ1VcgEU46m9KnsOCVKD3ceJWO7wQKs+erXswuJF3OpAaogSiMflwy80KAU/f83YALCLshOxcMSfkgKcdkhjK3cTjPoJsATYIdYwbNJL9RnscOliuOxuRbtzK/8PFqNDhprMn/uDeTlS855mdhY0jvlGEwdZ5Q6lFOpFX+L5M6EcFEdEgsgFYWqVR0TlWZEp8k1kiN+kTVu6SRt033mUwVqdsV0EMWtYYWFIZoGlrwK0QYK1H9OBvGQMad4/4t4JkhE6suJ2Ap7Er1nJxTq1k1yLatKPoJQsmRPDHulvt03g2Nfj6pYaa3JFRy1drWbw2tObHd+qwvOVlKCy2k/HPmsXShWedT33mtScQiy9lJ7Gn5RX+1zxyEzdlevpbcqc6pA2zVDg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb4d939-3e17-416a-3101-08dbfbbc649d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 09:17:56.5369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ynKBz88sWKZ2OVZrNzBYYWY09OZpOOqUbw2sn7DNrdvvCyFNo+3gOD2NFR36wECriwK/A+32VQlWe9IS+DiIzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_01,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130067
X-Proofpoint-ORIG-GUID: WK37Yy2v2icDNRKIPOfweQxeCLH2KH5p
X-Proofpoint-GUID: WK37Yy2v2icDNRKIPOfweQxeCLH2KH5p

On 13/12/2023 05:59, Ojaswin Mujoo wrote:
>> However - as we have seen with a trial user - it can create a problem if we
>> don't do that and we write 4K and then overwrite with a 16K atomic write to
>> a file, as 2x extents may be allocated for the complete 16K and it cannot be
>> issued as a single BIO.
> So currently, if we don't fallocate beforehand in xfs and the user
> tries to do the 16k overwrite to an offset having a 4k extent, how are
> we handling it?
> 
> Here ext4 will return an error indicating atomic write can't happen at
> this particular offset. The way I see it is if the user passes atomic
> flag to pwritev2 and we are unable to ensure atomicity for any reason we
> return error, which seems like a fair approach for a generic interface.

ok, but this does not seem like a good user experience.

> 
>>> We didn't want to overly restrict the users of atomic writes by
>>> forcing
>>> the extents to be of a certain alignment/size irrespective of the
>>> size
>>> of write. The design in this patchset provides this flexibility at
>>> the
>>> cost of some added precautions that the user should take (eg not
>>> doing
>>> an atomic write on a pre existing unaligned extent etc).
>> Doesn't bigalloc already give you what you require here?
> Yes, but its an mkfs time feature and it also applies to each an every
> file which might not be desirable for all use cases.

Sure, but to get started could you initially support that option (as 
long as it does not conflict with other per-file option)?

Thanks,
John

