Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1A55F6735
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 15:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiJFNEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 09:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJFNEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:04:21 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764B9A3466;
        Thu,  6 Oct 2022 06:04:17 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 023085803FD;
        Thu,  6 Oct 2022 09:04:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 06 Oct 2022 09:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1665061455; x=1665068655; bh=N6
        it90zhKBeS6kpjpWHzwwnMSuYeK60zqUPbb7rWWk4=; b=XTgNicp/w6VyyZaRPv
        n4u89Y3VpJN0otlae1qyySdCkPUukZ695QdJy/OCy3++7pohYhDzlWsBkWKlQJnF
        zawbDkPiWAL+qX37FxpvztDyhcIQ7u804FSnaWHTxgf00r6YgtQGLMJkZ5U6GYbR
        YubxB3iGl1ZgFlNzemCy84m07QUj0p16Zi9PQzv/5PwIHtMNwZL2Dhc+BED6Kl8b
        M5lKq1X5teQz4f9aj4K3r2NpFmepGMiE+WN6QNx1P8/w4AntZGlp4rCO0gzvzW69
        sDnJ7MAI0QQdTetsS2DYE/U8hSNjrA7HIjuawWRV7bLDET+jfZ08TCMnecqIqjrY
        GAdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1665061455; x=1665068655; bh=N6it90zhKBeS6kpjpWHzwwnMSuYe
        K60zqUPbb7rWWk4=; b=FAaPD96zc+b9K5xKH2cUqvkpol+I33Kkf0et42qgz8z+
        o1eNBQnQKM1AvC//U+cQVmrrqBd30HogyMEDiVxKvZdgTerM/pTVx2QnyIXOEv7d
        60qslQZq3oWYM357Kd0o2xFwFf/0neVFntfmjMVLCvmPvsd4RUTzfau1b5gQuKjR
        iwPI146Sf0m0L9eJr2iXTgvFnYamJOGcYab+IB4nXczcS1og8ic4XumxPvS6Inuh
        MF5f8pJHOqfKa4fTi/Zc+HEg6NZRImJn1PwL0WZzUPoojpighNgVGN7e2QnppkQB
        AyzUbVcL6ZrNN0AxCHcceqU3axK2l7bbi73RHaGaXw==
X-ME-Sender: <xms:TNI-Y_cADBTmEGpGSZoXpsnbr5cBkxj_NhkFnZrsm2yluGABn--W0w>
    <xme:TNI-Y1NvpK9thKw86UCe7rJ8yiX5AWUXVuvUmS7BsbCYx7l1rgp1Hf06pA9ptdAMn
    e03yjclKp-CO2o26go>
X-ME-Received: <xmr:TNI-Y4hQ7BaMUuWbsk8OvMCD4cp_6m7IvvkagIaoMywvoSSwmfD-0JJnobBS8vCOG5tQtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeihedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:TNI-Yw_mO4XX1-1h6dzQ5GGjTnQKz-0-O6J5r-Li9YBWT8GUM4OAQw>
    <xmx:TNI-Y7sySt_8cYEM97yWcmGUiiP8-42qYLx8qLDtOk4nm5HGI0M94g>
    <xmx:TNI-Y_E3ditAwkEwtCuCVsNs7bzaIfKHo7-Kml0mjUdfSlcsiX7qpw>
    <xmx:T9I-Ywqn5ZabLPAsbikF_Gw5naaIf9n3eKnvmUiBpBnm0z1YXEjQRw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Oct 2022 09:04:11 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 7C346104D90; Thu,  6 Oct 2022 16:04:08 +0300 (+03)
Date:   Thu, 6 Oct 2022 16:04:08 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Fuad Tabba <tabba@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Message-ID: <20221006130408.2bnuikg6peilaycp@box.shutemov.name>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <CA+EHjTz=o9M47frGCXgNJ8J5_Rn=YjzZR5uvCTxStw+GfGE5kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTz=o9M47frGCXgNJ8J5_Rn=YjzZR5uvCTxStw+GfGE5kg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 06, 2022 at 09:50:28AM +0100, Fuad Tabba wrote:
> Hi,
> 
> <...>
> 
> 
> > diff --git a/mm/memfd_inaccessible.c b/mm/memfd_inaccessible.c
> > new file mode 100644
> > index 000000000000..2d33cbdd9282
> > --- /dev/null
> > +++ b/mm/memfd_inaccessible.c
> 
> <...>
> 
> > +struct file *memfd_mkinaccessible(struct file *memfd)
> > +{
> > +       struct inaccessible_data *data;
> > +       struct address_space *mapping;
> > +       struct inode *inode;
> > +       struct file *file;
> > +
> > +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> > +       if (!data)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       data->memfd = memfd;
> > +       mutex_init(&data->lock);
> > +       INIT_LIST_HEAD(&data->notifiers);
> > +
> > +       inode = alloc_anon_inode(inaccessible_mnt->mnt_sb);
> > +       if (IS_ERR(inode)) {
> > +               kfree(data);
> > +               return ERR_CAST(inode);
> > +       }
> > +
> > +       inode->i_mode |= S_IFREG;
> > +       inode->i_op = &inaccessible_iops;
> > +       inode->i_mapping->private_data = data;
> > +
> > +       file = alloc_file_pseudo(inode, inaccessible_mnt,
> > +                                "[memfd:inaccessible]", O_RDWR,
> > +                                &inaccessible_fops);
> > +       if (IS_ERR(file)) {
> > +               iput(inode);
> > +               kfree(data);
> 
> I think this might be missing a return at this point.

Good catch! Thanks!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
