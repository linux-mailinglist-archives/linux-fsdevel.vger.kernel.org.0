Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D774A28E471
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 18:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgJNQ2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 12:28:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39016 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727071AbgJNQ2t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:28:49 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09EGJuAf019278;
        Wed, 14 Oct 2020 09:28:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wE/milm1p1kaoflniydrSkv+n8Byw8DJ/NeWeeTQgQM=;
 b=KfBwM7deZub0fWrwIvSIMOPDJt3MTe9ATlfrfOVNDcI2AMM1cTZeUK5RNWseJSRvPBjX
 2uHSMgJLjMeuWYUcreF7ITHyVCdTTJ3o7kh27wv50ERaFO/Gvy3eP3Hzu1zlI9iwbiJA
 jANhADUqqV1pWhi7UXgt3a1LM5jZhEqCwaA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 345e3reu4p-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 14 Oct 2020 09:28:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 14 Oct 2020 09:28:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEE42yuo+E7VC/bR8SUlmfrHJrN0/8p6sEQkbGHxINOeHqNGSs4/6pObVC4SSVIjGkK4proHnx0D87WKOe8DuwUVHiyMuaS1SE4oEPyA2mc87PWYZtD6XnpN5ybAfXe4W7vCzn65azRs9+x2i5WHxPG2zM6r1wp7Vyc6nvNYnc2E5D31rV4jGvPOFxACuTXcqDcPeeM8/lkHzPtpQ2q8jAFH334VJD1Gx2Wk1FujOH8NkNNgz1j+lStsMelhq8KLh3C87Ne0DGBoL66ShkkdJWWay0LrEME853KtEsjL3BGZWH+1SZEeaxWMpPGGFPFLo64zzB93OubQUNeWCn8h9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE/milm1p1kaoflniydrSkv+n8Byw8DJ/NeWeeTQgQM=;
 b=hSMw6VYWuou9kWhmJer1km5ut8rLzVppr3Ko2ncoe2OBJJJ1zuCmz4GNdS3MDau2Dy6D1gZrQzys6AlpaDRfxOm0yv4HTxwI+KeoQNyFKit2PmWcQdtyD5q3OwI5myxK7TyhtwLsBImHhqa6VZ0ITviVE/ukPP5JDwAbEyIlrIPyDCDDzq7QQjTz7zje6EPOurwlTqz8C/RT/ny91DzBby7Gas2p0rsIjME17ZRBDPBtSqoGdagTd8tewfpnzY/Gwk3ECmGV9Ddl7f/YqJupCGLaYWztMVLOPokS5rF/KbuB1NvtDwNjwldjkzMeRjr3jSQY7VKMphsaEIzBN5CHnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE/milm1p1kaoflniydrSkv+n8Byw8DJ/NeWeeTQgQM=;
 b=FboJI7/BXHFfwyiHODDACCF38AJpV2RjOZ8Fr+sb+n5UZPcgAByuIxFV5J72K6wKmfzJOnMNw2Oi2JDtDEOhfO+ZO/LBVTYQmqRA8K3GW5GCEbB2jW7IiOKVDN4WYCVZu4WtdRKITZKpHSUhEaMClFF8DkzVpLRHD4QOxrAol+o=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB2878.namprd15.prod.outlook.com (2603:10b6:208:e9::12)
 by MN2PR15MB2576.namprd15.prod.outlook.com (2603:10b6:208:12a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 14 Oct
 2020 16:28:10 +0000
Received: from MN2PR15MB2878.namprd15.prod.outlook.com
 ([fe80::38aa:c2b:59bf:1d7]) by MN2PR15MB2878.namprd15.prod.outlook.com
 ([fe80::38aa:c2b:59bf:1d7%6]) with mapi id 15.20.3477.020; Wed, 14 Oct 2020
 16:28:10 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: PagePrivate handling
Date:   Wed, 14 Oct 2020 12:28:06 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <1EFC2FB8-954F-490F-BE8A-D216ADA1C5E9@fb.com>
In-Reply-To: <20201014153836.GM20115@casper.infradead.org>
References: <20201014134909.GL20115@casper.infradead.org>
 <B60A55DB-6AB7-48BF-8F11-68FF6FF46C4E@fb.com>
 <20201014153836.GM20115@casper.infradead.org>
X-Originating-IP: [2620:10d:c091:480::1:e105]
X-ClientProxiedBy: MN2PR19CA0004.namprd19.prod.outlook.com
 (2603:10b6:208:178::17) To MN2PR15MB2878.namprd15.prod.outlook.com
 (2603:10b6:208:e9::12)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [100.109.123.254] (2620:10d:c091:480::1:e105) by MN2PR19CA0004.namprd19.prod.outlook.com (2603:10b6:208:178::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 16:28:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1094fdd-093a-4f65-2e98-08d8705e23e9
X-MS-TrafficTypeDiagnostic: MN2PR15MB2576:
X-Microsoft-Antispam-PRVS: <MN2PR15MB25761E1B882E2FA031EBE25ED3050@MN2PR15MB2576.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etZGnHtwt0AvOd2fZVASF1Ibn3D0olxW/KzX+pOrwZI+9pZv41ktNa058D8iG92lrIACGHjk4k46OIrrp+gou3Uoz3kC1OHQOiOUygI7D+vHOVmTg4n/zsY23uyp0ChRbnv8hto+LO0opSoHY58KnY4EC9/d41edDQ6JSZx++iWdC+Ni0QUpcOut4dIMVJy9kkx+Gktx5WVigfdVveT3TUfQuRZ4oK/qOKFZPKwuvUSG8O/kOeKG+RaqGrDm9OOicAGbZl7DaZna2lTmz4ajT5w4vpAlLKDNahnp3sfLk8L77F7gLC2oD44wJyvDqsKdS5UtdQpuBlYLVQPV3tTKezWK7w73Rs8BY0ibGHLfb2I9VO9nQM+MU2SxUZrpl0iFcIQ3i5dy4CL9xaUQRgmii4la7fr03vkXIMsETxddZTkpjZgj9W0o6K96GtEDlElJPoyroxT13Jj0hsyu6T7N/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB2878.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(376002)(346002)(966005)(8676002)(478600001)(4326008)(8936002)(83080400001)(83380400001)(36756003)(2906002)(66556008)(66476007)(66946007)(6486002)(6916009)(2616005)(33656002)(54906003)(5660300002)(3480700007)(52116002)(86362001)(316002)(53546011)(6666004)(16526019)(186003)(7116003)(956004)(78286007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: pQ1DZN5R92VNZRCOfs9nTwxGtjdI+wq9usDi0C7P6N0eSfa2A3AKFvjCj415cFrM3OObdO4RHkYOdSrEvAQYEcVOKK1AK4uFfkZNaZ3vvcWwTmISE0oNFErs9KslrjznjjKvJf2B54Zfnb5sFmdErHACbQ5y8/ptg0VSnbzTdx9itV5yqvvULJCmXRD7yCLpGVlEG3YyjUeLQ3JDILPC2FBo1OgGp8ECL1Ya+gAsSIL+uYvcfwlxme/YzAq6P4x5R4BZU0NwZjnViiMAPJf7CgDp8kL0xbe2Xg8WCZaO4yk4q4V6XYY5+RqsC1QRDEo/cDAzZCxRqAn017zAEfi5/edjc+bTVzwa7k+aTuFV0vHVxWOC7NbYCQlJZu09g7/1D6xvc5SmNQCBZfMb1HSu+4b8bY1M8VpvnuB2SljL4lrd3erDBynWArcJfAySxx3aFF2WkUIOupY8tgFuvPpHsYjSgT0/grtBm0xEWSwzVkTRxHsBdRI7R+eDZMMQQlTuI+6xBg4JfOs0JyGfcEnV9vzp5/IAaTg1Qw8gezknWTleHoh5Hk4ATCXsP7LBcVa0+D1PaJYYGDJA61goX3E4oJz258MxcwNcTBBzPHFC0hnScr2sQ3CjaSN6TbR7P9Dg/AD1X4MUMgezgqaQ/Z9gbs1CZcDzvYoH9AyWmPmYfsxxNtkU91zQ/9LvAM7A/eet
X-MS-Exchange-CrossTenant-Network-Message-Id: a1094fdd-093a-4f65-2e98-08d8705e23e9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB2878.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 16:28:10.7094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1jSfpv2c3DtX7nqF62iw5qxAfCpCmsQcJE1v2uhNjPEidfgRF77a4s+J+Y6uyXH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2576
X-OriginatorOrg: fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_09:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14 Oct 2020, at 11:38, Matthew Wilcox wrote:

> On Wed, Oct 14, 2020 at 10:50:51AM -0400, Chris Mason wrote:
>> On 14 Oct 2020, at 9:49, Matthew Wilcox wrote:
>>> Our handling of PagePrivate, page->private and PagePrivate2 is a=20
>>> giant
>>> mess.  Let's recap.
>>>
>>> Filesystems which use bufferheads (ie most of them) set=20
>>> page->private
>>> to point to a buffer_head, set the PagePrivate bit and increment the
>>> refcount on the page.
>>>
>>> The vmscan pageout code (*) needs to know whether a page is=20
>>> freeable:
>>>         if (!is_page_cache_freeable(page))
>>>                 return PAGE_KEEP;
>>> ... where is_page_cache_freeable() contains ...
>>>         return page_count(page) - page_has_private(page) =3D=3D 1 +
>>> page_cache_pins;
>>>
>>> That's a little inscrutable, but the important thing is that if
>>> page_has_private() is true, then the page's reference count is=20
>>> supposed
>>> to be one higher than it would be otherwise.  And that makes sense=20
>>> given
>>> how "having bufferheads" means "page refcount ges incremented".
>>>
>>> But page_has_private() doesn't actually mean "PagePrivate is set".
>>> It means "PagePrivate or PagePrivate2 is set".  And I don't=20
>>> understand
>>> how filesystems are supposed to keep that straight -- if we're=20
>>> setting
>>> PagePrivate2, and PagePrivate is clear, increment the refcount?
>>> If we're clearing PagePrivate, decrement the refcount if=20
>>> PagePrivate2
>>> is also clear?
>>
>> At least for btrfs, only PagePrivate elevates the refcount on the=20
>> page.
>> PagePrivate2 means:
>>
>> This page has been properly setup for COW=E2=80=99d IO, and it went thro=
ugh=20
>> the
>> normal path of page_mkwrite() or file_write() instead of being=20
>> silently
>> dirtied by a deep corner of the MM.
>
> What's not clear to me is whether btrfs can be in the situation where
> PagePrivate2 is set and PagePrivate is clear.  If so, then we have a=20
> bug
> to fix.

I don=E2=80=99t think it=E2=80=99ll happen.  Everyone in btrfs setting Page=
Private2=20
seems to have already called attach_page_private().  It=E2=80=99s possible =
I=20
missed a corner but I don=E2=80=99t think so.

>
>>> We introduced attach_page_private() and detach_page_private()=20
>>> earlier
>>> this year to help filesystems get the refcount right.  But we still
>>> have a few filesystems using PagePrivate themselves (afs, btrfs,=20
>>> ceph,
>>> crypto, erofs, f2fs, jfs, nfs, orangefs & ubifs) and I'm not=20
>>> convinced
>>> they're all getting it right.
>>>
>>> Here's a bug I happened on while looking into this:
>>>
>>>         if (page_has_private(page))
>>>                 attach_page_private(newpage,=20
>>> detach_page_private(page));
>>>
>>>         if (PagePrivate2(page)) {
>>>                 ClearPagePrivate2(page);
>>>                 SetPagePrivate2(newpage);
>>>         }
>>>
>>> The aggravating thing is that this doesn't even look like a bug.
>>> You have to be in the kind of mood where you're thinking "What if=20
>>> page
>>> has Private2 set and Private clear?" and the answer is that newpage
>>> ends up with PagePrivate set, but page->private set to NULL.
>>
>> Do you mean PagePrivate2 set but page->private NULL?
>
> Sorry, I skipped a step of the explanation.
>
> page_has_private returns true if Private or Private2 is set.  So if
> page has PagePrivate clear and PagePrivate2 set, newpage will end up
> with both PagePrivate and PagePrivate2 set -- attach_page_private()
> doesn't check whether the pointer is NULL (and IMO, it shouldn't).
>

I see what you mean, given how often we end up calling=20
btrfs_migratepage() in the fleet, I=E2=80=99m willing to say this is probab=
ly=20
fine.  But it=E2=80=99s easy enough to toss in a warning.

> Given our current macros, what was _meant_ here was:
>
>          if (PagePrivate(page))
>                  attach_page_private(newpage,=20
> detach_page_private(page));
>
> but that's not obviously right.
>
>> Btrfs should only hage
>> PagePrivate2 set on pages that are formally in our writeback state=20
>> machine,
>> so it=E2=80=99ll get cleared as we unwind through normal IO or truncate=
=20
>> etc.  For
>> data pages, btrfs page->private is simply set to 1 so the MM will=20
>> kindly
>> call releasepage for us.
>
> That's not what I'm seeing here:
>
> static void attach_extent_buffer_page(struct extent_buffer *eb,
>                                       struct page *page)
> {
>         if (!PagePrivate(page))
>                 attach_page_private(page, eb);
>         else
>                 WARN_ON(page->private !=3D (unsigned long)eb);
> }
>
> Or is that not a data page?

Correct, extent_buffers are metadata only.  They wouldn=E2=80=99t be Privat=
e2.

>
>>> So what shold we do about all this?  First, I want to make the code
>>> snippet above correct, because it looks right.  So=20
>>> page_has_private()
>>> needs to test just PagePrivate and not PagePrivate2.  Now we need a
>>> new function to call to determine whether the filesystem needs its
>>> invalidatepage callback invoked.  Not sure what that should be=20
>>> named.
>>
>> I haven=E2=80=99t checked all the page_has_private() callers, but maybe
>> page_has_private() should stay the same and add page_private_count()=20
>> for
>> times where we need to get out our fingers and toes for the refcount=20
>> math.
>
> I was thinking about page_expected_count() which returns the number of
> references from the page cache plus the number of references from
> the various page privates.  So is_page_cache_freeable() becomes:
>
> 	return page_count(page) =3D=3D page_expected_count(page) + 1;
>
> can_split_huge_page() becomes:
>
> 	if (page_has_private(page))
> 		return false;
> 	return page_count(page) =3D=3D page_expected_count(page) +
> 			total_mapcount(page) + 1;
>
>>> I think I also want to rename PG_private_2 to PG_owner_priv_2.
>>> There's a clear relationship between PG_private and page->private.
>>> There is no relationship between PG_private_2 and page->private, so=20
>>> it's
>>> a misleading name.  Or maybe it should just be PG_fscache and btrfs=20
>>> can
>>> find some other way to mark the pages?
>>
>> Btrfs should be able to flip bits in page->private to cover our=20
>> current
>> usage of PG_private_2.  If we ever attach something real to=20
>> page->private,
>> we can flip bits in that instead.  It=E2=80=99s kinda messy though and=20
>> we=E2=80=99d have to
>> change attach_page_private a little to reflect its new life as a bit=20
>> setting
>> machine.
>
> It's not great, but with David wanting to change how PageFsCache is=20
> used,
> it may be unavoidable (I'm not sure if he's discussed that with you=20
> yet)
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/com=
mit/?h=3Dfscache-iter&id=3D6f10fd7766ed6d87c3f696bb7931281557b389f5=20
> shows part of it
> -- essentially he wants to make PagePrivate2 mean that I/O is=20
> currently
> ongoing to an fscache, and so truncate needs to wait on it being=20
> finished.
>

It=E2=80=99s fine-ish for btrfs since we=E2=80=99re setting Private2 only o=
n pages=20
that are either writeback or will be writeback really soon.  But, I=E2=80=
=99d=20
prefer this end up in a callback so that we don=E2=80=99t have magic meanin=
g=20
for magic flags in magic places.

-chris
