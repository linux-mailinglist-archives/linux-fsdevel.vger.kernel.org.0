Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC21293ECB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 16:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408136AbgJTOdP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 10:33:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64968 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408012AbgJTOdP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:33:15 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09KEOFKn016543;
        Tue, 20 Oct 2020 07:33:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=tM8Gr01FWepPCALQMlNdtDpxR4MH8oddWYwfCrL26YQ=;
 b=ITtb96WWopNAcCj/MDT0UTYmXwtngddGrg3HLAReOtqKpa0pwt/wFiap9HaDTTNJBCiy
 XhwtD8cMQmcZhrc19FNMxbvcHUy3wVo0/2Bdjfi/FAnk5Ky2Kwo73e7juWbXhMV3Qf8b
 dAQiaDedhkQaxskuIbOVhow71r0NBQNk0lo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34a01e0jgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 20 Oct 2020 07:33:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 20 Oct 2020 07:33:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANqKTUWU9phvx6HAm0c+BMiCajltzgvsCvxDXQcFECEyQLMI7vQ0R/f3ouU4NTTZbqgGyclSDHg8fJEgeqEmFrx9WH/mKhEzVB7P0FnNethvSogAnagYSzMMxqHZG2JJs44vJgAMmYlSR4H7MvOFskKVzRmW+5FX1AmiCesiSKjj2j1nrK09MYeUSDrXYJZt54OZYLvzJxW7oJnVX3Jrhp6gPbpKiHdNNyw5gi+kpS1jX7b53wKsWXg6Ra2MppdenVojzoEW6xBEhdc3B0pxy2AxdDs430Tt7klVfwamPpcJZ/CF9CS5wzaEzKlKMFEJAQXfswuwwohJvNl7SC+p+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tM8Gr01FWepPCALQMlNdtDpxR4MH8oddWYwfCrL26YQ=;
 b=ggf4tw3ou0ivVbYcoivgpIcbPyS+tLTvaLAf/Bph0wWooaxcW2zJJ1Sn4rYRR04NnvynQohK0Lj7XVRAKeHV2u25NLciSmqm/lzOpREIsWq1iFFJfg/NNeKkkxLjZgWswvlnt7iBrIn14UYSNM7KdNdLvwPbEmepdQnHpNqkKDk6SY5/AfK8XuKzR2ly3B5SujZ5bFVPATtUUI4ODOk9aFmfsadKuV70kVRtsAuRFdiMLXQARZjTOMuLYnxMFd8p033J6WDg31KJJCefEhjXi6kDiJdUhgowpF8Q3MoPEseOATkn+3zC8Mh1jtBPG+2yciCj/ZtIkLdWPcD0ijT1ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tM8Gr01FWepPCALQMlNdtDpxR4MH8oddWYwfCrL26YQ=;
 b=LyT1l1me9hc5XGQsDD4X7CPIXK1rnZDhdbRDGFWJ1zWw/Mk+0s3ONXenM3QZQhZZmgcAJ93ivLy1PC3StmRtqcaKWAFHOIAEqr9CxghFnGGmd0aHve0Y+sH9QDVNE2ww4z360wWzzpeb66MMlQ0p3QnOofMOno8XxEGatliteqg=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB2878.namprd15.prod.outlook.com (2603:10b6:208:e9::12)
 by MN2PR15MB3421.namprd15.prod.outlook.com (2603:10b6:208:a1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 20 Oct
 2020 14:33:02 +0000
Received: from MN2PR15MB2878.namprd15.prod.outlook.com
 ([fe80::38aa:c2b:59bf:1d7]) by MN2PR15MB2878.namprd15.prod.outlook.com
 ([fe80::38aa:c2b:59bf:1d7%6]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 14:33:02 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>
Subject: Re: Splitting a THP beyond EOF
Date:   Tue, 20 Oct 2020 10:32:59 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <AD1D4324-F072-4E8F-9594-BC450A215ED3@fb.com>
In-Reply-To: <20201020014357.GW20115@casper.infradead.org>
References: <20201020014357.GW20115@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c091:480::1:704b]
X-ClientProxiedBy: BL0PR0102CA0044.prod.exchangelabs.com
 (2603:10b6:208:25::21) To MN2PR15MB2878.namprd15.prod.outlook.com
 (2603:10b6:208:e9::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [100.109.29.250] (2620:10d:c091:480::1:704b) by BL0PR0102CA0044.prod.exchangelabs.com (2603:10b6:208:25::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 20 Oct 2020 14:33:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79a23545-a1bd-44a5-9ee2-08d875050cdd
X-MS-TrafficTypeDiagnostic: MN2PR15MB3421:
X-Microsoft-Antispam-PRVS: <MN2PR15MB34213203C2CDB4300694156DD31F0@MN2PR15MB3421.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vcEx9IHRLLFZ0BFZeIHy2YtudnhsHPZOZzhSQ+irX+Cuw4OJ53DY+AZ5DBnhVJY7fA9iVODnXXiyjffX+lNX8pOik1kR2ywTbMz+0d7hpUpoxGL4qAy//L36vX9bojaAsAUhnJBjDBgqN12uJC1svVfzbbFAzRFWEc0ojo/onkjX5kvFssMqs3AyrsreTyGJNAPYdVv2MSSxGOKUffaFiM9wgYxbfQU4pG7CnABh896tSZjakHO0PUuS+0guPxaQXgnxq4rSHOGoM4/usc0s0z/nkhHV77xW5ORoXSsvNNoJX8g69Pi7OgxUfJ298pKNpGRfCEqGVJNAUx/x7SJ1ofl+QG0BGuky8/xC5tUBB+sBBe2FoN0vHcRSIXdoO1on
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB2878.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(366004)(136003)(39860400002)(6486002)(316002)(478600001)(956004)(6916009)(86362001)(8676002)(8936002)(36756003)(2616005)(53546011)(4326008)(16526019)(186003)(2906002)(33656002)(66556008)(66476007)(52116002)(66946007)(5660300002)(6666004)(83380400001)(78286007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: S2g+ly6IW9o9FcpjpwiaUJQ76WPGvxQmLDay1HB/fS/IHKEfhj1BFF93kgoDLsy3MlZ4dXkSAvqnLDehUAr+ZRICiqsAFrzlzFPHKHoVptAfGG/ekClJRtvPy/sFJkGV3XkO8kkq7GSfd48LdzWMDFG8Z9YEJpmUsJOmFAdIEndP2AqCIMKF/BZJVzQgsJmjqdV3aifvxTRa/SqcyjVrJP+INIB5TIXqTEkMy+45GQP50Lv7aQyCN7DPG0LTZKW7vJOx6FMyIzpJ7ZvmL2hwDuoo/8tMnW6ckB7NajkTKUN8DkTLg5L9pxz2d4dPhKhX3lQ2h3et+jkyv6PF1hkOL+QT8mwIY3R2R2aqoAgK5je/nyCsUoYJ7Igc8aIeA6QOVtlZ17Ofc/fAs/GmRTpsjJ1JTD1dqXRiNpCitXbI44/UI46ZCZc9+dB+ZfgV5ZMVT2/uAwon8pGg051u0YNzkxzjdDIAXslADgsaV6TDWzyZbHsAqzlHI8CPdy0m5+D2HBhPjSV2m53rds9bsIdR6KpUhoE9mIpTr7ONvGdRYUW7y9udGSQ3bkY8178n2XimtLN++gKMmYC3HxSIcTbiCYabrTwZkuNWxVvFFuVtB3V/K114f9HitEaMnv31oHNQQQjO3d8Rdg2z/9AiRAk53skkWOx0xYJsy0BYK8CK4lTOrBpDnHZOT1OAJ9/NX7+B
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a23545-a1bd-44a5-9ee2-08d875050cdd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB2878.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 14:33:02.7330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0zA4/QpFfEHwB+pOV5qvInuo1ddE0+47iiz+37NStuiWNe76pSrS2JFwAawhZc1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3421
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-20_06:2020-10-20,2020-10-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1011 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010200099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 19 Oct 2020, at 21:43, Matthew Wilcox wrote:

> This is a weird one ... which is good because it means the obvious
> ones have been fixed and now I'm just tripping over the weird cases.
> And fortunately, xfstests exercises the weird cases.
>
> 1. The file is 0x3d000 bytes long.
> 2. A readahead allocates an order-2 THP for 0x3c000-0x3ffff
> 3. We simulate a read error for 0x3c000-0x3cfff
> 4. Userspace writes to 0x3d697 to 0x3dfaa
> 5. iomap_write_begin() gets the 0x3c page, sees it's THP and !Uptodate
>    so it calls iomap_split_page() (passing page 0x3d)
> 6. iomap_split_page() calls split_huge_page()
> 7. split_huge_page() sees that page 0x3d is beyond EOF, so it removes 
> it
>    from i_pages
> 8. iomap_write_actor() copies the data into page 0x3d

I’m guessing that iomap_write_begin() is still in charge of locking 
the pages, and that iomap_split_page()->split_huge_page() is just 
reusing that lock?

It sounds like you’re missing a flag to iomap_split_page() that says: 
I care about range A->B, even if its beyond EOF.  IOW, 
iomap_write_begin()’s path should be in charge of doing the right 
thing for the write, without relying on the rest of the kernel to avoid 
upsetting it.

> 9. The write is lost.
>
> Trying to persuade XFS to update i_size before calling
> iomap_file_buffered_write() seems like a bad idea.
>
> Changing split_huge_page() to disregard i_size() is something I kind
> of want to be able to do long-term in order to make hole-punch more
> efficient, but that seems like a lot of work right now.
>

The problem with trusting i_size is that it changes at surprising times. 
  For this code inside split_huge_page(), end == i_size_read()

         for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
                 __split_huge_page_tail(head, i, lruvec, list);
                 /* Some pages can be beyond i_size: drop them from page 
cache */
                 if (head[i].index >= end) {
                         ClearPageDirty(head + i);

But, we actually change i_size after dropping all the page locks.  In 
xfs this is xfs_setattr_size()->truncate_setsize(), all of which means 
that dropping PageDirty seems unwise if this code is running 
concurrently with an expanding truncate.  If i_size jumps past the page 
where you’re clearing dirty, it probably won’t be good.  Ignore me 
if this is already handled differently, it just seems error prone in 
current Linus.

-chris
