Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDDE69910A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 11:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjBPKXI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 05:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBPKXH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:23:07 -0500
X-Greylist: delayed 736 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Feb 2023 02:23:05 PST
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC501A64D;
        Thu, 16 Feb 2023 02:23:05 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id EF2C4581F74;
        Thu, 16 Feb 2023 05:01:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 16 Feb 2023 05:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1676541714; x=1676548914; bh=mU
        wZ0jLBJxHz2jqLQpzE2WZti2villst4pazhry1LDk=; b=asp+w4tFm/0L+ogLMm
        Aah1xvH4AC5j6a6LcApo6uCb3V6IY8r2ikkDaJR2FB7shHkGsgS8TyPVHysvz1wl
        w7G3DJVe3kyuaXTizspLXlv3dJBwdw64oluQvhEnmtO4wfuyeISDBd6koC5smlpl
        c93B3qTaOlQ4qQH+023WPx+j/T99sQC2oSsiiLdLbmjIl2Ea27cka8xxchVgLeve
        2iThLMVvWxeyJ8/+TtsHp414ynVa9p8Ek5ApwrgL7rZwSTPWcV36dqF+GqYO8/Dy
        1WBs+dM4cIQcKpj/xukVy46UYiPY04WL8AW6VZXgpBrsVwNylSig3yXUWWzBeko4
        D/Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676541714; x=1676548914; bh=mUwZ0jLBJxHz2jqLQpzE2WZti2vi
        llst4pazhry1LDk=; b=tjURGj5OYhitZIFJH3pTuYCsW7QnYHGo+Bne0z8nqsMe
        1vE03qoSKLsFpwrfX45Li0aYqbWQm4stNaS+vt48/4lKLIjocyVldJiCveFBfosz
        z1zO21pN4R/OzCph8SEKEFFabqMyT2/AI11YU8k8hPU4nDeuJnfB8orvpWtkHJyT
        9mZGqb+AKEOq7igi7qO71E1BN9IKsiUYj0+uGfblt1DBv9l3HV4NB/LxejoHDK8a
        Re5iX+uoxlS4q0MeYcJEFDpzZxspfZMJAZuyRJEeItqZ6bNa39wmmelk/84cmodq
        jRXd7aIoo1nGJiyBaZUIp7vf0F5yoSOrbVFLya1HVg==
X-ME-Sender: <xms:Ef_tYzaWl82N0I06rUgcVq24rgB0UPCcY_uZCX5iMdPrN79_UTiyYQ>
    <xme:Ef_tYyaVPVBOKK0gm-z_DyI7flgQuvDSu3EG7BaDzT2yhKmqV-mpAiN3ChBJhHpN3
    36E8wlywbwfeB-_lBk>
X-ME-Received: <xmr:Ef_tY1_9oOigwbr3GGpJODva1Y__qcK34XggsAHHIDjA9f4TX0aN_mQBvPjK5NI0x87C_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeijedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:Ef_tY5qnpuptUFz_7q9O0jrLxFFrdoyPKTcdPLw4Oe4i1P9ucNbHbQ>
    <xmx:Ef_tY-p8xe27YBBU1UELy8V2QuAQ-IGOmMnZ8rbJaTvFU0viy-Jabg>
    <xmx:Ef_tY_QH7z8xTeiVhI_VGSg6zgQX4ss2bNezQMrty9LRd49QHytaLA>
    <xmx:Ev_tY7OboPatSl1njimvH7MDK1iQT2H5wcb75YSbti-YfrG81Ou-SA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Feb 2023 05:01:52 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 93F7210CCE1; Thu, 16 Feb 2023 13:01:50 +0300 (+03)
Date:   Thu, 16 Feb 2023 13:01:50 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org,
        chao.p.peng@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, akpm@linux-foundation.org, arnd@arndb.de,
        bfields@fieldses.org, bp@alien8.de, corbet@lwn.net,
        dave.hansen@intel.com, david@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, hpa@zytor.com, hughd@google.com,
        jlayton@kernel.org, jmattson@google.com, joro@8bytes.org,
        jun.nakajima@intel.com, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, luto@kernel.org, mail@maciej.szmigiero.name,
        mhocko@suse.com, michael.roth@amd.com, mingo@redhat.com,
        naoya.horiguchi@nec.com, pbonzini@redhat.com, qperret@google.com,
        rppt@kernel.org, seanjc@google.com, shuah@kernel.org,
        steven.price@arm.com, tabba@google.com, tglx@linutronix.de,
        vannapurve@google.com, vbabka@suse.cz, vkuznets@redhat.com,
        wanpengli@tencent.com, wei.w.wang@intel.com, x86@kernel.org,
        yu.c.zhang@linux.intel.com
Subject: Re: [RFC PATCH 1/2] mm: restrictedmem: Allow userspace to specify
 mount_path for memfd_restricted
Message-ID: <20230216100150.yv2ehwrdcfzbdhcq@box.shutemov.name>
References: <cover.1676507663.git.ackerleytng@google.com>
 <176081a4817e492965a864a8bc8bacb7d2c05078.1676507663.git.ackerleytng@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176081a4817e492965a864a8bc8bacb7d2c05078.1676507663.git.ackerleytng@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 16, 2023 at 12:41:16AM +0000, Ackerley Tng wrote:
> By default, the backing shmem file for a restrictedmem fd is created
> on shmem's kernel space mount.
> 
> With this patch, an optional tmpfs mount can be specified, which will
> be used as the mountpoint for backing the shmem file associated with a
> restrictedmem fd.
> 
> This change is modeled after how sys_open() can create an unnamed
> temporary file in a given directory with O_TMPFILE.
> 
> This will help restrictedmem fds inherit the properties of the
> provided tmpfs mounts, for example, hugepage allocation hints, NUMA
> binding hints, etc.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  include/linux/syscalls.h           |  2 +-
>  include/uapi/linux/restrictedmem.h |  8 ++++
>  mm/restrictedmem.c                 | 63 +++++++++++++++++++++++++++---
>  3 files changed, 66 insertions(+), 7 deletions(-)
>  create mode 100644 include/uapi/linux/restrictedmem.h
> 
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index f9e9e0c820c5..4b8efe9a8680 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1056,7 +1056,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
>  asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
>  					    unsigned long home_node,
>  					    unsigned long flags);
> -asmlinkage long sys_memfd_restricted(unsigned int flags);
> +asmlinkage long sys_memfd_restricted(unsigned int flags, const char __user *mount_path);
>  
>  /*
>   * Architecture-specific system calls

I'm not sure what the right practice now: do we provide string that
contains mount path or fd that represents the filesystem (returned from
fsmount(2) or open_tree(2)).

fd seems more flexible: it allows to specify unbind mounts.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
