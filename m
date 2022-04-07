Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF494F8599
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 19:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345973AbiDGRMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 13:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345991AbiDGRM3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:12:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC191E814F
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Apr 2022 10:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABB52B82795
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Apr 2022 17:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64194C385A4;
        Thu,  7 Apr 2022 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649351419;
        bh=4Bi+StaZdOPFXAdU/bNHFV7mZV6B2itRPcHJI8amDrg=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=u9TLtj76C8m9CC/tH7uQ7MlfCEWIi+QNH/YhOnoZ9xa/e9MdwAaItd74EmSTmNJKj
         HOr5CIZ7jsLIxtluoCWxg8Ao3Zx+DUVpo4P5PQ1vGpMcDrKfRyLTBGLnd6BLBkkYaZ
         BYBhwWLsbrQLvaln61cfErbSWkxUEMoyB6idvNPq8Y0+s2XiS+LCdpMxfs2N/5cLoH
         WN6cIKF8yDkDa37YZGAvsL10YCBchgRdWDMJw7Ez/xSwxKFZSOD1tSm0nuKrPyGsOn
         w9B1VnQyj/no82a/jOGdxOucrTSdfFvGcU1ABMXjbwjTxx2Np1xrFjgzvAIpM5JOkG
         Og7zspGQiS5sA==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 43D7427C0054;
        Thu,  7 Apr 2022 13:10:17 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Thu, 07 Apr 2022 13:10:17 -0400
X-ME-Sender: <xms:9xpPYiwigi4XrLyD8aQhAtA3_YTzg5eSJ6ZATs9IpU1MaIGI2aZwdw>
    <xme:9xpPYuQwoqgTttF5HfpG6tdWD_Hpos3j_Ms_B-QvDWqIXv3kuCCtj_qbT8wGqNWEa
    wRjaIy3kU_T0uHyIME>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejkedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieev
    ieeufeevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:9xpPYkUBjEYrRtFpUrgzG-httf3qhdjIXmL8z_XpnJtMzXXUWbHEmA>
    <xmx:9xpPYoj0PxmCUASx1bpPa_AbhKN79WQgg59JHpV1YZtxdNU4Z67Mkw>
    <xmx:9xpPYkASkc8dReovZGQ8JvhGvgz9cxZty7kHQflwPrPmFSM1NWuh2A>
    <xmx:-RpPYksc_XgrMpOOUS14uwdssfqA4aFocpF7qDkidsJfDRUc2jxlRQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AC96021E006E; Thu,  7 Apr 2022 13:10:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-386-g4174665229-fm-20220406.001-g41746652
Mime-Version: 1.0
Message-Id: <02e18c90-196e-409e-b2ac-822aceea8891@www.fastmail.com>
In-Reply-To: <Yk8L0CwKpTrv3Rg3@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-5-chao.p.peng@linux.intel.com>
 <Yk8L0CwKpTrv3Rg3@google.com>
Date:   Thu, 07 Apr 2022 10:09:55 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Sean Christopherson" <seanjc@google.com>,
        "Chao Peng" <chao.p.peng@linux.intel.com>
Cc:     "kvm list" <kvm@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>, qemu-devel@nongnu.org,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        "Wanpeng Li" <wanpengli@tencent.com>,
        "Jim Mattson" <jmattson@google.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Hugh Dickins" <hughd@google.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Steven Price" <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Vishal Annapurve" <vannapurve@google.com>,
        "Yu Zhang" <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "David Hildenbrand" <david@redhat.com>
Subject: Re: [PATCH v5 04/13] mm/shmem: Restrict MFD_INACCESSIBLE memory against
 RLIMIT_MEMLOCK
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Thu, Apr 7, 2022, at 9:05 AM, Sean Christopherson wrote:
> On Thu, Mar 10, 2022, Chao Peng wrote:
>> Since page migration / swapping is not supported yet, MFD_INACCESSIBLE
>> memory behave like longterm pinned pages and thus should be accounted=
 to
>> mm->pinned_vm and be restricted by RLIMIT_MEMLOCK.
>>=20
>> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
>> ---
>>  mm/shmem.c | 25 ++++++++++++++++++++++++-
>>  1 file changed, 24 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 7b43e274c9a2..ae46fb96494b 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -915,14 +915,17 @@ static void notify_fallocate(struct inode *inod=
e, pgoff_t start, pgoff_t end)
>>  static void notify_invalidate_page(struct inode *inode, struct folio=
 *folio,
>>  				   pgoff_t start, pgoff_t end)
>>  {
>> -#ifdef CONFIG_MEMFILE_NOTIFIER
>>  	struct shmem_inode_info *info =3D SHMEM_I(inode);
>> =20
>> +#ifdef CONFIG_MEMFILE_NOTIFIER
>>  	start =3D max(start, folio->index);
>>  	end =3D min(end, folio->index + folio_nr_pages(folio));
>> =20
>>  	memfile_notifier_invalidate(&info->memfile_notifiers, start, end);
>>  #endif
>> +
>> +	if (info->xflags & SHM_F_INACCESSIBLE)
>> +		atomic64_sub(end - start, &current->mm->pinned_vm);
>
> As Vishal's to-be-posted selftest discovered, this is broken as=20
> current->mm may
> be NULL.  Or it may be a completely different mm, e.g. AFAICT there's=20
> nothing that
> prevents a different process from punching hole in the shmem backing.
>

How about just not charging the mm in the first place?  There=E2=80=99s =
precedent: ramfs and hugetlbfs (at least sometimes =E2=80=94 I=E2=80=99v=
e lost track of the current status).

In any case, for an administrator to try to assemble the various rlimits=
 into a coherent policy is, and always has been, quite messy. ISTM cgrou=
p limits, which can actually add across processes usefully, are much bet=
ter.

So, aside from the fact that these fds aren=E2=80=99t in a filesystem an=
d are thus available by default, I=E2=80=99m not convinced that this acc=
ounting is useful or necessary.

Maybe we could just have some switch require to enable creation of priva=
te memory in the first place, and anyone who flips that switch without c=
onfiguring cgroups is subject to DoS.
