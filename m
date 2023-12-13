Return-Path: <linux-fsdevel+bounces-5849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D6F81126D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69330281277
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7E72C862;
	Wed, 13 Dec 2023 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="je/P1Z1V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v+LcmImB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801CCD0;
	Wed, 13 Dec 2023 05:04:15 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDCsgbd009436;
	Wed, 13 Dec 2023 13:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=A5tpDHTxqizoicFmRBn5uZ5fN1ELgAlITteSCXHZyCA=;
 b=je/P1Z1Vtc0L2EmX9e87PMlX8qCVttmYOuMFPvMs95mJ1KAPQSlVaqx2STiXahw7Zm85
 QUm60MOfpy2CGq1DQcD3aYHaeS+RmaOc4C7N0U44zW9cxD7tTERkXCLHkizi5EGnTHJK
 FLPCQUrj03Cw5UWJzGLcahX4WEKQ84R5+5gY3bIT86Dgm3fO6kxcmVS0h9e43MGyNYaI
 8mZSDC0UTq1JkimffyJQ+0gEDcdeuMReV5z6Oo3CE7QjWsgJaScOxN0r/3MIobrRRJ+I
 ADgBIHyUc0ebnqnZFwgnWn11a1oHJtIhhH3xraAK9iOoKkIXbH17zwk13hiFwpjvm9xf dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvf5c85xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 13:03:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDBUC8O010151;
	Wed, 13 Dec 2023 13:03:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep87fyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 13:03:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3zLZNlwg2/7D4bkTxxK21aBaSK889r7N3JeXLxSE2gIQCOhMERxLenzXnAxSJWjOESp/7NwXXjw8AlD7RoZKzkwL3aLMzdEAMwpU9adG0vpnwSBCXEM1xEJ0sEmjxqhn+2/Oews8+Iic6SrcgyBeBbD+SBVrXHSc3gSxB0nzCOdZ2uMcvax7twk4a3AOfov1t4EWinUgQWmVdin2BOdHr047MrKWzY8WH9C1vw9ltUU1HQ5Fz4s3WUC+BWdKROc2SY7mKJUvuGl3Cp67v1PQgcO9dBj6qJjNa9jE8h3RyMiDE5n2qOz9AD5uv5kkZMhwZlUcltanI00m/6rkNQBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5tpDHTxqizoicFmRBn5uZ5fN1ELgAlITteSCXHZyCA=;
 b=ku5+XK480QyC3DuSURuWixBaG2r0pVaNqAdSh8iGjBJAr3z6nGA+/zPjcyolCj/x50fyJRBjuoq2M6mRbmaL0Ld1fadooFsGEabAqBFXt+wjAT6dcc975uNri/3qYr20MenQ6kzzGAkVEBc4TTdnPloABDwOzL2SmNHf0NbWTbgDrQ6ylU0jhDO2L8QJAJaS0BF2BkxQppI1KhJzi7lzTmBlSOdRrNeypEX4vfvFe1bP0wAt/1s4rPpU5onLK5hXc7OD53urnbSvHPJco3XficxppcBzJWBEjQOmxDpJbm5pCE5P0UFrSviSp0xW71HEyfDjQXUzUAFEjJh+nm7S1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5tpDHTxqizoicFmRBn5uZ5fN1ELgAlITteSCXHZyCA=;
 b=v+LcmImBWElH9O2c+z+PIl5aLXJa779MWJYlYE6+Dq3XpBfozgpQqi268+iMcp1rr3PuBGpDxxXruqmJOMLEwsK2llcy8rOs6NzsbLLyFOtozXkFyZWS48meBLn2hu8bwpEHleoFH+3PfHhQ04vVkT33ED1JpE3e3Ou+tQkOoxk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6799.namprd10.prod.outlook.com (2603:10b6:8:13f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 13:03:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 13:03:36 +0000
Message-ID: <58037a2f-cbae-4bc1-bea4-604f6951b709@oracle.com>
Date: Wed, 13 Dec 2023 13:03:30 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/16] fs: Increase fmode_t size
To: Jan Kara <jack@suse.cz>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, jaswin@linux.ibm.com,
        bvanassche@acm.org
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-5-john.g.garry@oracle.com>
 <20231213112026.kkfcwtg64kiadhn5@quack3>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231213112026.kkfcwtg64kiadhn5@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0124.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: 34eef5dd-fa49-4716-0076-08dbfbdbead0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9f0hpxbdTDp0Gm3vp/zMz7JKhvwmKIEbChcQ5TnKzybKh1cch1iPibD/LkJeeHdO/kVYWBXe7lPUm5GgHu5ehshL/DbQ2jxI1Bl8jknIMdBBR6oPFWddfw1P0VqxkLraN4liOUMfJZuE+zGSBT2z8RgRgmvNOy8e+sdMvkgft25ONesvKc5gfQIYT5gyk89R8hpNEO00iuR8MRVvfaoMQpAfR9fUAqrBRVConsF9IvClNHvjhtl9y5+vytO8KKlRkn9sBZhKpkYOhjgBqo8z9hNTT0a7dAKkWBrMGb8gnzU9e5nwRDibKmMT9agxQHpnSc3qgqMJJD829Bi1GJJVZTeHTufMbhEPNGhV89nDpABvlhOluBsAAW4hxP7YfQhYj3NFD1RqTIQtgqbV11f6IHmaVaLs5dXZ3hXEZ/P3DW+mf1LVmu7lrhlaWBn+svctIm5M5UMmXb6s+aVt4QaqkVnb8hYb6cOl8wKV3FF9w8qHNtMG7F3YDl8nE10inrbObPNrzCfvSyzIcAXg4OMZkuKz0cfI7HOsQyPbkiq5wICI4ZqlpgdB1JCJ5nzUWij/NfnqLswHM5SYBUpCEcoqY3OWqoT5LKGjGQfUlAFsRQxenvKeGxNKtF8PrcrhgbnoPO/z5ssteMhAzjeuWl9AnduSaea3vVZiDMprMQNDLLpXqgnS2hafogjZRkEbT2eyUN59/qRkloumQg1FEYbqag==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230273577357003)(230922051799003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(31686004)(66899024)(66946007)(66476007)(66556008)(36756003)(31696002)(86362001)(38100700002)(83380400001)(6512007)(2616005)(53546011)(36916002)(6506007)(8676002)(6486002)(6666004)(7416002)(2906002)(6916009)(316002)(478600001)(8936002)(5660300002)(4326008)(26005)(41300700001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TGMwaHlUMkI3eHdVNEhCWUVWR1FxZVQxN1NGS05GZnFoOWJSaXFMR3VzVkdp?=
 =?utf-8?B?cEhSdWQvYStrbE9wbTQ5dmd5eU1wUXJ3WXkxVVc0NmNTOHlDV28vblhhK3RX?=
 =?utf-8?B?SThBb3NRcVE2TUxlaUNnS1djNVFvc0dKazduRnBORlRURmRUdERJOVN1UGZU?=
 =?utf-8?B?OC9udVBlOTZuTTVudTBiOVJaaTR0OFNIektJcllJc0V6bFhsTTVvTGZZa256?=
 =?utf-8?B?elhIQ2VkNVM2bEdacnd6UHFDUEV6bnpxdTliUHBQRXJYNVlFcWpId3cvODhQ?=
 =?utf-8?B?TEhINnRrZXB0OEVtaTYxUUZsaDcyYytJOE1HN1ZEUkdGYWVYWGtCbkRXbnVp?=
 =?utf-8?B?SHkwblpVNEdUQmVadm5HVFJLRGlielgvOFBZUEpkQStVa2lYQXVKQXFVSnBG?=
 =?utf-8?B?Qy9OUlBCcVBTREJvU3EvZ0tIYm9lMllkYUsxZDdOdkJESnFxWWdIRWFaNEFv?=
 =?utf-8?B?VFEwZmdzaE1HNnU0L3pJWEthZTFDdS9GTVVmY2doalkxVmkwbFZ4VnJEUFhS?=
 =?utf-8?B?TFJIVkorRkY1RXFLUkZVZ0RSMVZ1ZW9Dakl5NVhNdnhjb0Y3aktGdzdkeFAz?=
 =?utf-8?B?WnB1M1crUGxrdjlLeHZpaWptRFRiQlRoZ1QrM2J2Q3B6UVRFMlFEMEo4RVZj?=
 =?utf-8?B?TE5HYmErM3IrTk5KL2ZCK1pGdERCZWVaQVdmQjRyZlN4b1Z4RGVDWENuZkpp?=
 =?utf-8?B?d1ZSTXlONkhveVdKdWFIQklIUFJhS2FUMURYTzZkQmYrQTAzRnNjWWZaR210?=
 =?utf-8?B?MkNZYjdDc3ZZT3FSREZlNE9aR20zd2JhSE1EdWxyTVBkWWtxNFZhTTZRS0xO?=
 =?utf-8?B?Q0VPYVJ2cWZkUlp2eThPdVE3cit6RERvczhtUzZ5RU5Bc2hISno4S3poK2pQ?=
 =?utf-8?B?bGFkUlhuV2l6Y3B0VUNBSjkycmVzVzFGTituVnhHcVg1T0hoMWFXeXd1cE5M?=
 =?utf-8?B?cjB5VkduV2RUSHlYdkIraHl4elRycWMxcU9oRXN4ejJheGhpaHVxYzNwenVE?=
 =?utf-8?B?dHVsaWlrSEY2eE1nSDJ3WTR6bmowMG01dS81U3c3clFFZzQ0bXc2ZDg2MElU?=
 =?utf-8?B?bUd1SFRGeFRVY1BSM0s2VXQ3V0p0U2VLZWxNSktIdHFoakFRZFZndHpHNnd4?=
 =?utf-8?B?UmJXKzI0SUFneEloakNxVnNGM3BucjBGbGRCV1F6MWFiVUpSYXhUQ0JESmRv?=
 =?utf-8?B?djltbndsUG9YTFRrZWI5cFNMR21HVDBoMXUrWXI2c3pWOG1RMUM4ZzZXa3RS?=
 =?utf-8?B?QmpHL0p5Ry9DdTBjQzhJSFEzenhKZE5iZUMxRERRNG44RVkvYkI4SGVpQmhu?=
 =?utf-8?B?YWE1V0cyMUtRbU1yNjlXc0EySUhhVzdDNXNFYndwVzhPZ3BENmVkSGpoWTRT?=
 =?utf-8?B?NG1Qa2thZGJZYW91R1l6MjhWbUFiLzVhWEVFaSsyY2pRSDlIa2dMdFFFb2lT?=
 =?utf-8?B?b3lObzE5Qlllc1pHdWY1SkFrblRqcHo5ZEowRFBwWUJnNTMrcVVGbHNEOFRm?=
 =?utf-8?B?WWJXNElNd1RJRVAxQkVTdFNXNC9RV1gza3JiUnlRTWdFSUtJUUppR3h6QWpz?=
 =?utf-8?B?NEpOck41emltNjFuZCt4WXhSaVJESWlNWFdKQWdYNVVsNE9wd1g5b3Jac214?=
 =?utf-8?B?RFdzdDA1NTA0eGJwdDlZcUpidS9yQXhZVS94Y3g2cmZFMXVMZjNRSVhvRHNH?=
 =?utf-8?B?REN6eS9Ba3hUQXc2blBaaVk5YlhiOUw2VVYwZ0tkcmR6dE1nZUdmYVJLWGQ1?=
 =?utf-8?B?S1lWQUI2NHpvUndtVlNVL0tWNjdQVEVIbjJ4M016dEJueEhNNWdWb0dHL05D?=
 =?utf-8?B?akhwLzlCMk9NV2o0TWFJK2N5RmpNSVdoN2xwaU5NUVJ6R0grRnNpMzdBRkhn?=
 =?utf-8?B?ekttd3hPRHNaTy95SVpPM2kxdTFHbktrdDcyYVF2aHNnN2JrVkFJcFhnWEw2?=
 =?utf-8?B?RHlKZUxNTXloTjdkaVJBL3NFcUZXSWRKZXBiNFZGeUVPeEVwTXdQbUVGRUdS?=
 =?utf-8?B?eHRHcXgrL01NUmpEWXVBbnV5MTJsSVBpSEhKWFRoVnJRQmJHWmJhenRZUjY5?=
 =?utf-8?B?WnVzQmRrRzhDa3FNVjJtL3VSNldLaE83UHdBSmVpS2xPaHhvbXNyLzJIcVll?=
 =?utf-8?Q?4TNFRFKy0lChy0vQ3k+66rw8O?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	R/bBEITkTNorZltqYQB3A3B/EkL7XOK7x0HkzoywdaGSAVzk4hK0gaWEx0P8ROzCFolSGEsXseCbb27eh4Xx20N5HuanbX5U9AOkD7pBVEOd87Sf9avIXNcyN0UoGBex2WRdhsznU9fmMuS1sCZCYIUVQXuroxDszb4OA7DcSWwdf3pAm8A4kaJTZoeurhrPBx1RfNTsIsLlGeqceFL5g5oXolFFnzsssiOxU5Tu6irjTm1lADSRwttqRmMP5q+UUtYXCkTYJH3ZpS/OaAnioU8YKJTL/mWqOhZH4JQ51o+0AyXr6iUI4zLcwHrecDnnp/4atLZH7825SLvG/kg4VfegAQzMov3C5MzIG46+9UNATPaVBOJeTaEPv1FtGkM9d3wp4SDvL9nwSLWCdiCvv6RqiRG2A1MFyLRqxY/JaTxJYh+iTAUOTHdhuCYLs3c2o5BOBGF2MjJ3Hp1SuswSE9ltoNVsvQVB8uxXTZdf+02L+CLpVmFlRou+2VCxWFEfqXi4OjsZmgt7VjoQEsuQy9SKx+hKrmIBbf0bUw4wZLVX/a9n8AN9fAHql27dFCBDkSZQE+iIunUqJyZwWexLtClnAHhqi23uFAbODIngR1s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34eef5dd-fa49-4716-0076-08dbfbdbead0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:03:36.1293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPYxn79DxKk5iF4PIvNdtgDKvF2vxR6EbN16rBtgloKZZCLoAg3Z/xYoY1HnmJXjOSqSo0T/CjFT37Yq/Pi45A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_05,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130095
X-Proofpoint-ORIG-GUID: cE4HmDVkSSsEQnhapUKqYNZdoeYMRSYh
X-Proofpoint-GUID: cE4HmDVkSSsEQnhapUKqYNZdoeYMRSYh

On 13/12/2023 11:20, Jan Kara wrote:
>> To allow for further expansion, increase from unsigned int to unsigned
>> long.
>>
>> Since the dma-buf driver prints the file->f_mode member, change the print
>> as necessary to deal with the larger size.
>>
>> Signed-off-by: John Garry<john.g.garry@oracle.com>
> Uh, Al has more experience with fmode_t changes so I'd defer final decision
> to him but to me this seems dangerous.

Ack

> Firstly, this breaks packing of
> struct file on 64-bit architectures and struct file is highly optimized for
> cache efficiency (see the comment before the struct definition).

 From pahole, I think that we still fit on the same 64B cacheline 
(x86_64), but some padding has been added.

Before:
struct file {
union {
	struct llist_node  f_llist; 	/*     0     8 */
                 struct callback_head f_rcuhead 
__attribute__((__aligned__(8))); /*     0    16 */
	unsigned int       f_iocb_flags;         /*     0     4 */
         } __attribute__((__aligned__(8)));	/*     0    16 */
	spinlock_t                 f_lock;	/*    16     4 */
	fmode_t                    f_mode;	/*    20     4 */
	atomic_long_t              f_count;	/*    24     8 */
	struct mutex               f_pos_lock;	/*    32    32 */
         /* --- cacheline 1 boundary (64 bytes) --- */

After:

struct file {
union {
	struct llist_node  f_llist	/*     0     8 */
                 struct callback_head f_rcuhead 
__attribute__((__aligned__(8))); /*     0    16 */
	unsigned int       f_iocb_flags;	/*     0     4 */
         } __attribute__((__aligned__(8)));	/*     0    16 */
	spinlock_t                 f_lock;	 /*    16     4 */

         /* XXX 4 bytes hole, try to pack */

         fmode_t                    f_mode;	/*    24     8 */
         atomic_long_t              f_count;	/*    32     8 */
         struct mutex               f_pos_lock;	/*    40    32 */
         /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */

> Secondly
> this will probably generate warnings on 32-bit architectures as there
> sizeof(unsigned long) == sizeof(unsigned int) and so your new flags won't
> fit anyway?

Right, it would then need to be unsigned long long. Or add another 32b 
member for extended modes. There were no i386 build warnings.

Thanks,
John

