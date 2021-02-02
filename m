Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B1D30B4D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 02:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhBBBup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 20:50:45 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48826 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhBBBuo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:50:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1121i9bD057655;
        Tue, 2 Feb 2021 01:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=kYhchVCGqEtQIBogUE34p5RLd/lQkoIj4JVERKX3tSI=;
 b=lDc0J7f/NsoX9qPqMVUTFJehGmYJriGuvjWOLzXfIxLW5rs1AlUaDt8Xc0QJYUnT8SCj
 AJXwem5GS33/YntEwI5Kdx2zrwlVaWMR7WZ8SSQ43edqnJDQEfHg6Tg+IguCCAS7KCh8
 2s873GWR06sbvOutKooPTL0G3u199R7TqGN0fV2lXvT4BwAl4YBAopVYvjOz7K+cXMKO
 XJcUZk5l7fEM7Po6OWgVuK1uTXzXw6enhpRIrqTEv+oMwgYQWxjH/b+/jd69rOZPWU35
 GoEaNYEx1Jyy4YtxF3mXY+pOxih2Z6pLf2uDcfdHtALjdUUolaRNmfDN3Vs/jhX/hKhg Ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36cxvr0crw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 01:49:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1121eV8h036184;
        Tue, 2 Feb 2021 01:49:48 GMT
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2055.outbound.protection.outlook.com [104.47.45.55])
        by userp3030.oracle.com with ESMTP id 36dhcvvwkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 01:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOvP1AAnYHa7PWG90drlYDzbvMWt+1yw3PYxYr7Fz21Fk4Fz/+oZaAhtet9ylTb7IwdKJmniAzAN1ezNNgMf6J/zuxAdj+dVnccX1xaZztUW+domRttMeKv210j9HaSzx1PcXdfz/BvT+vGiytCgN+YjW8nyYc6OykndBUOO8UkL2vhP2/UViyDnFvEr8zfL82LSKAdvh7sxdY900gXFFAbjZewnNU42BrBT7h+M9qit73FJzVVYFVXGjdK4ASq/jwavmiENfKM8+yYNiVWh3RlY2QNuQczLyRs6C1+TToEipnnTlMuvlOS4f/lCnQM7iCc2mIavE+iAzo9fwCBIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYhchVCGqEtQIBogUE34p5RLd/lQkoIj4JVERKX3tSI=;
 b=CxNsBSo9DIItXai+IsFkeWDpR+7LlD1kg0kPMIPwCjBDmIqzQbIcNQ6sD9R+TTeezDj5SadBBq7GP+RS8m8ARg/nxVWbnRp6GrK0wQWF6qwRyiCKDJ3te0wStn9p9HJxTfaGaAlb2avluyAsbUwhYlSrPC1m1ghRXCndhbZ9E2w/rIVVI3OCelJP4sWDn/lJZ7BWBamY664lHN2V5GSOX60y4p/5rYxMDLcENtc9Id/pQr7Gsx6BrupaJPYUQ+Eg/jmvxtlWT7b/hKgZIhY9NYN963gGGaN/ZrvRKC1kunpk2V1LPB+P5oeA681hy3WrT9urG4zwdDqjFfZigZT1rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYhchVCGqEtQIBogUE34p5RLd/lQkoIj4JVERKX3tSI=;
 b=SBdeyTMXbT3Qr1ohpg3rpGdQI0A1vhDkIXVOKbyPKJplqklTuvku+3Q65pdVvnWka2B2SiAGWdV/tW0DeKiMVfVZorf5NxqgfUvKMqmsIkUAEQgZHWm3FQDHcq6onCSJ3V9R6HjJG+8FV/dO3e3WovKNe2gM4jzjcMx1k/iju38=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN6PR10MB1842.namprd10.prod.outlook.com (2603:10b6:404:fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 01:49:45 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 01:49:45 +0000
Subject: Re: [PATCH v14 08/42] btrfs: allow zoned mode on non-zoned block
 devices
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <613da3120ca06ebf470352dbebcbdaa19bf57926.1611627788.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <64c76676-db10-afe1-6b38-ca748d7fb27a@oracle.com>
Date:   Tue, 2 Feb 2021 09:49:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <613da3120ca06ebf470352dbebcbdaa19bf57926.1611627788.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:3d13:e439:ea65:32c2]
X-ClientProxiedBy: SG2PR03CA0145.apcprd03.prod.outlook.com
 (2603:1096:4:c8::18) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:3d13:e439:ea65:32c2] (2406:3003:2006:2288:3d13:e439:ea65:32c2) by SG2PR03CA0145.apcprd03.prod.outlook.com (2603:1096:4:c8::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.13 via Frontend Transport; Tue, 2 Feb 2021 01:49:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c38daf50-00a2-4a7b-f722-08d8c71cd0d1
X-MS-TrafficTypeDiagnostic: BN6PR10MB1842:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR10MB18426822C63AE8289BB78DE0E5B59@BN6PR10MB1842.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:241;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CXuQUcdblGqtlphckMjCaSjCppCcYpaXQJRxrhbLJp7N2FXWHpcWi04MNC4OJQIFyytKtsscaechChzASMikC6R2+6TNLn89JjcG/A73RmeO6mqQiOVG2LLhYDsWwUbJxbAw8Mmvy2bDg2bf/RWZGK3ELvRWHATqiUcnL8gKA7wiQwvjM1dBMeHyMCSjBH944szLdjSr/MDJj8tv5KFTvovfChabM12J7lA652Lj5nJF3HLtKoXoyzVcGb2nINXAPNmIgHzFIKJqjSxYM9lhkjMD58UD3XhQ7X6GkI9vl/4/sbH2kzem8fskHpZon1tETRxBVVXcsQSKdx+cdXw3UFrVLljfBcIor+WDtt04gqXGu5l2GqyPqeG3qqGtkIYYlNFabPGacWCoRkVJrTTgNysZiHTnTA+zDwFuu5jIVKyEl34d9bpEPg3bAYH/XoEtFlgQyh06Wr0cs9ayM7qQeWxmgZmkWbVnJyCXTJ3o/ptblTyobFHY3JWaslWwofLFqTy+Mw0DpUQfBh7+BdGYEyu3HSk5Tx9Od03rZ2bSOHV7x2nZ4vHRXIMMa9kj9MtsiMLBY73EaOSKtVJ75Upa4yECJGIfgMLMC7l5w2ua7CE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(376002)(346002)(366004)(316002)(86362001)(2616005)(4326008)(31686004)(186003)(16526019)(53546011)(44832011)(2906002)(31696002)(4744005)(8676002)(83380400001)(36756003)(66946007)(66556008)(66476007)(5660300002)(8936002)(478600001)(54906003)(6486002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Rk1PS0R0TTc4UzFoRHRwZUtza2xtVDB3NFdFU08ybHMrb2xkZ3N3QkpJMFhh?=
 =?utf-8?B?R2U1WElHVUJ6K2pwaENxQWF5TU9ybTJIeGN2anV1bW1KWmJtUEhHR2NZMENO?=
 =?utf-8?B?bEFLUDk1NVlQMzRYZ0h5SDJnTkNNRkN6eEN5WWJFMTFvcUF3ZC9UT2lzR1hr?=
 =?utf-8?B?d0gyZSswbU5GRzNZU1pxOWxXZ1cxNURwM2lIaXpHTUhUY09SWStSRkg3V2wv?=
 =?utf-8?B?cHF0VVBkK2h6Z0lEbUhDa2p3UElPR3QyZitRbGgyZXNlcTA5TFo3QmhtLzFm?=
 =?utf-8?B?cVN5SFNDSVZraUFaN3JPZGFjclNXdjdOdnJ3OXBEUkpEcVVoNzFuL24zQjAv?=
 =?utf-8?B?V0JQR3h5Z0piMG4zZ3g3S2VFUll3VzBVUVVseVM3S2syazBiTURCMGY4ZlJE?=
 =?utf-8?B?MmhVRkVtYWpJcTBPT3JTUXJyV0l3c1JjOVNzelVPRlZ3S1E1Y3ZSK2tWWG0w?=
 =?utf-8?B?MEpjenZjV0JoUGxMOW40TU5HdFk3SDJ5NytnKzQxY3VwWWpSblAzZlArSDRO?=
 =?utf-8?B?cVowZGlhT1lVcHZtMWdqb2VnNE1hNGlRRjhvYkhlQkg4WE0vMkwrcEljQ2ZS?=
 =?utf-8?B?L05RVkVTTEtLSW81Uzl0Vng4V2hFMXlNUUo4STlScjVHcWJnalQ4a3E3M29D?=
 =?utf-8?B?WS8zVVhsMUtqM3A4dk85Yk5mRVdoS3NFN0NEYmtzTU95eGpNOXJlR3NKMmRw?=
 =?utf-8?B?Vm9DQmY3MEd4MW10Qzdnb2pXNW10azEwalN2RnFZYzFRandBdWNmZ0ZTMjB2?=
 =?utf-8?B?MG5rcWlLRWowWnJ6N1R6MEZUT3hiMVN1ZWN0enhXZkdtMG1BTWdvVU42MGNr?=
 =?utf-8?B?NW54UGx3WjM2b2F1NDdlMi9mZktsdmVwK1dLOWp6U1FNNlIvL051alphOUdp?=
 =?utf-8?B?ZGlKZkx5WmIyTmowVVQxVXJVRXc0TnpEdFY0NkhpUjRXM2U5SjEwRlluL0Fs?=
 =?utf-8?B?S0J0Z2VBa2tMaUpLWndRcXNGdU5HdkRWazdmajQxc0RBS1hqdUV4K0dQMVNE?=
 =?utf-8?B?bGVGTUF3a21iMFpvM2JVZHpGdVFEVmRub2dvN3hhV25PdlJxNEtKUnQ2NnNx?=
 =?utf-8?B?RWM4UExuTzhhTUcxQ2N0dUxaczRIOTlLdHhhcThObjVqbXBlSzNGamhwUW5S?=
 =?utf-8?B?SHpPdlh6YnAyMEVhZ3RvQWJtMDkxbjY2bHRGQklWSzNWbFNLMTlUdThrVGRE?=
 =?utf-8?B?RFYwUzA0SE1GMXZ4UU03bExwR0dVdS9DMUpEdUJZQnlML0pzcXMzUGxYbGRL?=
 =?utf-8?B?blhzMW8zajM0NnFQbktKZnplYnZxVHkyaUFlOHFxR1czdnNXK0ppNEUvUFp1?=
 =?utf-8?B?RGM4U0JmaEE1Ti8yZ0dyaENkcjJwWlVqcHZIN1FoZ3NFZ0F3dVRqNUNCUSsv?=
 =?utf-8?B?c3VXYmJUVk9lUGx1THlHeDNvemdOTmwxbDVRMkRPcWg2UW9wMUdOTkNycmti?=
 =?utf-8?B?ck9sb1pBOWpsdys4eDl3V21KbnNkcHJXc3JZOGh5WGxpVGtwOVlYRG5rNUxv?=
 =?utf-8?Q?Lnlnr9DkYRnJraQaGvnr1TAF/Hb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c38daf50-00a2-4a7b-f722-08d8c71cd0d1
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 01:49:45.3586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCZvSseyMZypVqShxG0SusVe8fMMQ6TA+NDGk2Hq9CogwM2A0nXycy6u4jqdw4SNwvEiG9uyVcK7BfbJmxlIeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1842
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020009
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020009
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/2021 10:24 AM, Naohiro Aota wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Run zoned btrfs mode on non-zoned devices. This is done by "slicing
> up" the block-device into static sized chunks and fake a conventional zone
> on each of them. The emulated zone size is determined from the size of
> device extent.
> 
> This is mainly aimed at testing parts of the zoned mode, i.e. the zoned
> chunk allocator, on regular block devices.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand
