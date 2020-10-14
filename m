Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4F628E280
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 16:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbgJNOvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 10:51:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9872 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729276AbgJNOvW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 10:51:22 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09EEnrL4017037;
        Wed, 14 Oct 2020 07:50:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=1Wzso4Fz19sTe5idSM2izxkRy2+JO964wd+O+jrevds=;
 b=eDp3TnpJNGLd33k+GJXJ3V4k4Nhx3CyKfzCSzM4yYvSrivZWDrz8kh78dTQDOqVcH4zb
 pC9jb7IOU2AAdtq8HlP1hJFJsWF4zmLXPUp3k767TMhMTyMEOAUkD5pdAOf8KOx1QACf
 KPruGvx46aZlFAy6iaGi1odlyjjK2uVOx20= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 345e3re976-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 14 Oct 2020 07:50:57 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 14 Oct 2020 07:50:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2BRbVtJyFVEMeO2wClAZ4GOASxVwe1c7nKv9a6mCZZy3HaOM+KUSfqLxU/kyExNSYjeRc5ekIVg4Jm6UXpNbbO3MFG+jmlhKoC6WR930yfpKJ4BPKfEYm1DP6SF6VYgtgSIBUIgOH4MAD/spQaqjUiWX+N3qsjigXi7S8pp1iv/Vn4cNr7iE4OcxBqe/G5oB9Qslcv9OudWH6OilaLlgWQGWlY+xLVQ7c0YzlHvTKI3vGaKbrZuwWhUad8rTY8w9dNZngGmw6Y1FpPHmqOaPm4u/E3PhvLMRWgn2I2JWKh2EHdQWC/DOGZhDAVfA23jDxepoOS+nHJZjhMKVkbhhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Wzso4Fz19sTe5idSM2izxkRy2+JO964wd+O+jrevds=;
 b=EYjzq0qvWywQCHgpkvbjGIILQm5fDklCPk99AZyRaDjxjzaZhb9Cy2NV4/SwDe4aein/w3rXKHiloVXiJmehaa4Y8tSyqWz+Ycemn+HW1VI+NaDAAW2Z5/NM7w2RNUplex4YjQR7p1cqGIfmj4dGr2eb8Vr1PWOfAqU/wIBAnx5CH9E3Fq3EVlK26OMktARyivuaCPg5okVpx9F5HKfmwipCwQkMptX3pTzi283bDpt4x8wLTxni3HTbknoVm8RNU1OPWfuePOIyzW2CYT2NekHLpWJ4QWJ79nX9GsGOYzrxjVz1PRuK1kt/bHnyEAup6mdlwmTMancjePXfjFe4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Wzso4Fz19sTe5idSM2izxkRy2+JO964wd+O+jrevds=;
 b=OJKIkusWzYLJGzZ7AyQsBOq7wz0aCvS6HikCjfzGNgxkxmA1Z/MgMxDWuO6fIxVXc4vvv606FFuP1uPxG/5D57dMBu1h8OCmsN+tJcbjRTVYbNKbB5kV5lDAYgxmbXHFi22ByEtvo27+7RbjMFVid9Fp+zoYqrJg/LJQ5eQcBGI=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB2878.namprd15.prod.outlook.com (2603:10b6:208:e9::12)
 by MN2PR15MB2605.namprd15.prod.outlook.com (2603:10b6:208:126::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 14 Oct
 2020 14:50:54 +0000
Received: from MN2PR15MB2878.namprd15.prod.outlook.com
 ([fe80::38aa:c2b:59bf:1d7]) by MN2PR15MB2878.namprd15.prod.outlook.com
 ([fe80::38aa:c2b:59bf:1d7%6]) with mapi id 15.20.3477.020; Wed, 14 Oct 2020
 14:50:54 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: PagePrivate handling
Date:   Wed, 14 Oct 2020 10:50:51 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <B60A55DB-6AB7-48BF-8F11-68FF6FF46C4E@fb.com>
In-Reply-To: <20201014134909.GL20115@casper.infradead.org>
References: <20201014134909.GL20115@casper.infradead.org>
X-Originating-IP: [2620:10d:c091:480::1:e105]
X-ClientProxiedBy: BL0PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:208:91::17) To MN2PR15MB2878.namprd15.prod.outlook.com
 (2603:10b6:208:e9::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [100.109.123.254] (2620:10d:c091:480::1:e105) by BL0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:208:91::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.4 via Frontend Transport; Wed, 14 Oct 2020 14:50:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3024a1e8-18f7-4a90-c4a2-08d870508d1d
X-MS-TrafficTypeDiagnostic: MN2PR15MB2605:
X-Microsoft-Antispam-PRVS: <MN2PR15MB2605641E959A584191128705D3050@MN2PR15MB2605.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cMw40ooSH3ilOu+r0V/0/WzD6hnOsSuHIsZMTr5BQemPh2OUSd6DIV/L9eU+kwgImewJL86N9zXI6goJgkKdLE/veNPGn1AQlhMblg2tz2l63QrgEiK8BF6nTiEHya2seWCFEfHsVtrM+/t4mBrM4ppSA2/uGEZEAagf4jTjl2Y7kF83FJGUk19BMUEjYMVncjG8i2j+yMfHaamwp/s/9kmxxLJUM65F2/ogscLs0dLfp3CSzstjJG2i8bX8CtyeqsYErN3VCfYP4pcDe5X5MUfuseqh/FEJtt+RVDHVS/kI+wTQlVzEePWYmsYicAW11lIT/CfRB7vu/XhRtpkM7yHA1Dm6tj20pm/OkGyQ0nNtU5+/RjIi3WyDexV9Wc54
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB2878.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39860400002)(366004)(136003)(5660300002)(54906003)(52116002)(8936002)(478600001)(36756003)(8676002)(7116003)(33656002)(316002)(6486002)(2906002)(4326008)(2616005)(956004)(53546011)(186003)(16526019)(3480700007)(66556008)(86362001)(66476007)(66946007)(6916009)(83380400001)(78286007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: gSLyBQo8wiO+EooBeic+t5ecU5YLgGnCEVm06BMc5BpdSOz16s2C4n8is/LxVbmZEtJ0lnw0EYsL7GS33ygLlQ9wGbNDPxzMa+Al6u+laZWxnbrg+yfTZwdKoHz/v44A9djQC6mI+KN+2/7IBOA+42gAzEKQo6ksyoR7udYom64ceM8Lj9IpQa0DGWgdIbu2Z0YgwiPdT+3g4DU9lHkgLGlPskRhVAQ/tPAHWe6gzvtIYY+rujezfu8PoyP9nu8qeLJ40r3wCO0fSOVkiDP0vr3P4uEBIBBnfDeUuilvqa2/ZT0V8aPsrprc1v+rxbhl/EdoYVCNp3nZGZ5Wk8DFJzoS5Qe7F3G2toX8XQXV712Tut6MBlV9ehd66+1qY18h70VIeFuBl+RI8tfq6mLK9nv7Logo0Bte76u4A34AhyQE3IEUJsSN8shS0AxPlPIX+r6ujjiBsOSWcuKW8ZlpvmKcpo2GQahZDApBLnEUFUpqu7qGukAHFDWicxWEfjyEHwirXBlxF0ImgVtpCIxKRaBlpO1O61t4pHzhgnD4PltHkbpwLTdD4RhKKxBh8XJZUtyFHhpdSbWCHtwqXUCdkyRupKmN1vWb+aQDWdHRyZADo7kC0ighmpbhEdqjJAxEtOnvl39rYPQbJ9SboAtPR8TWkMpG0J0o8jSHdSoH7YQauvzRPSHV5OtftnHicbt+
X-MS-Exchange-CrossTenant-Network-Message-Id: 3024a1e8-18f7-4a90-c4a2-08d870508d1d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB2878.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 14:50:54.3536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6X97+p3+vqqUPmzp5FXyw9EJf4sRHjIEk7um6UPYMAs8wi6kIQ5flV9LripSyaXa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2605
X-OriginatorOrg: fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_08:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 suspectscore=2 mlxscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14 Oct 2020, at 9:49, Matthew Wilcox wrote:

> Our handling of PagePrivate, page->private and PagePrivate2 is a giant
> mess.  Let's recap.
>
> Filesystems which use bufferheads (ie most of them) set page->private
> to point to a buffer_head, set the PagePrivate bit and increment the
> refcount on the page.
>
> The vmscan pageout code (*) needs to know whether a page is freeable:
>         if (!is_page_cache_freeable(page))
>                 return PAGE_KEEP;
> ... where is_page_cache_freeable() contains ...
>         return page_count(page) - page_has_private(page) == 1 + 
> page_cache_pins;
>
> That's a little inscrutable, but the important thing is that if
> page_has_private() is true, then the page's reference count is 
> supposed
> to be one higher than it would be otherwise.  And that makes sense 
> given
> how "having bufferheads" means "page refcount ges incremented".
>
> But page_has_private() doesn't actually mean "PagePrivate is set".
> It means "PagePrivate or PagePrivate2 is set".  And I don't understand
> how filesystems are supposed to keep that straight -- if we're setting
> PagePrivate2, and PagePrivate is clear, increment the refcount?
> If we're clearing PagePrivate, decrement the refcount if PagePrivate2
> is also clear?

At least for btrfs, only PagePrivate elevates the refcount on the page.  
PagePrivate2 means:

This page has been properly setup for COW’d IO, and it went through 
the normal path of page_mkwrite() or file_write() instead of being 
silently dirtied by a deep corner of the MM.

>
> We introduced attach_page_private() and detach_page_private() earlier
> this year to help filesystems get the refcount right.  But we still
> have a few filesystems using PagePrivate themselves (afs, btrfs, ceph,
> crypto, erofs, f2fs, jfs, nfs, orangefs & ubifs) and I'm not convinced
> they're all getting it right.
>
> Here's a bug I happened on while looking into this:
>
>         if (page_has_private(page))
>                 attach_page_private(newpage, 
> detach_page_private(page));
>
>         if (PagePrivate2(page)) {
>                 ClearPagePrivate2(page);
>                 SetPagePrivate2(newpage);
>         }
>
> The aggravating thing is that this doesn't even look like a bug.
> You have to be in the kind of mood where you're thinking "What if page
> has Private2 set and Private clear?" and the answer is that newpage
> ends up with PagePrivate set, but page->private set to NULL.

Do you mean PagePrivate2 set but page->private NULL?  Btrfs should only 
hage PagePrivate2 set on pages that are formally in our writeback state 
machine, so it’ll get cleared as we unwind through normal IO or 
truncate etc.  For data pages, btrfs page->private is simply set to 1 so 
the MM will kindly call releasepage for us.

> And I
> don't know whether this is a situation that can ever happen with 
> btrfs,
> but we shouldn't have code like this lying around in the tree because
> it _looks_ right and somebody else might copy it.
>
> So what shold we do about all this?  First, I want to make the code
> snippet above correct, because it looks right.  So page_has_private()
> needs to test just PagePrivate and not PagePrivate2.  Now we need a
> new function to call to determine whether the filesystem needs its
> invalidatepage callback invoked.  Not sure what that should be named.
>

I haven’t checked all the page_has_private() callers, but maybe 
page_has_private() should stay the same and add page_private_count() for 
times where we need to get out our fingers and toes for the refcount 
math.

> I think I also want to rename PG_private_2 to PG_owner_priv_2.
> There's a clear relationship between PG_private and page->private.
> There is no relationship between PG_private_2 and page->private, so 
> it's
> a misleading name.  Or maybe it should just be PG_fscache and btrfs 
> can
> find some other way to mark the pages?

Btrfs should be able to flip bits in page->private to cover our current 
usage of PG_private_2.  If we ever attach something real to 
page->private, we can flip bits in that instead.  It’s kinda messy 
though and we’d have to change attach_page_private a little to reflect 
its new life as a bit setting machine.

>
> Also ... do we really need to increment the page refcount if we have
> PagePrivate set?  I'm not awfully familiar with the buffercache -- is
> it possible we end up in a situation where a buffer, perhaps under 
> I/O,
> has the last reference to a struct page?  It seems like that reference 
> is
> always put from drop_buffers() which is called from 
> try_to_free_buffers()
> which is always called by someone who has a reference to a struct page
> that they got from the pagecache.  So what is this reference count 
> for?

I’m not sure what we gain by avoiding the refcount bump?  Many 
filesystems use the pattern of: “put something in page->private, free 
that thing in releasepage.”  Without the refcount bump it feels like 
we’d have more magic to avoid freeing the page without leaking things 
in page->private.  I think the extra ref lets the FS crowd keep our 
noses out of the MM more often, so it seems like a net positive to me.

>
> (*) Also THP split and page migration.  But maybe you don't care about
> those things ... you definitely care about pageout!

-chris
