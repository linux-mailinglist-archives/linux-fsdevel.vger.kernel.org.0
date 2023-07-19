Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8982759C4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 19:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjGSRWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 13:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGSRWJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:22:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272D9189
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 10:22:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9891c73e0fbso227326466b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689787326; x=1692379326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muf27eIntjXr3Sa3gdcQLPN4y9AYfVWt2TffDnLSMcw=;
        b=yA9Vox816zD+aJ/FVd+gHS1eUUrpLebV0UPRWoTOQXRhwbDjiEzKfZKLt7ZPO+mtvH
         SaibLGPqQv8DRVnknibkmwFWbPPfcXmr6c+ujgDGBFuCW/F/BitDoK4IVXsvCkVTbM2a
         UUXFrIHyb9EtmF0G0jSo223YyW0H9eb4QyBBeSzBXy3UqItMc2tyGgaUGUFrdupt+8A5
         dLZgmELLzzoUW2SKSL+4MBdgHsq0BaZC4v7p3QuLBtrY+JwzHEa0w4RaSfJgn6bTpTvs
         oKq8cg7sWg40yA0HzTTcfPzlRvV46kkywbP49vwd3eHSPLgVvqkoTlu6Tp2eaYz6GzrZ
         sQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689787326; x=1692379326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muf27eIntjXr3Sa3gdcQLPN4y9AYfVWt2TffDnLSMcw=;
        b=ANAf9G288oToB2q8zEJlAQKXm/lsA8R1CWapv2HJZhZkdDWlrM1bTUUHi7qR+H2gG3
         yl/w00sUcZX1MJ+ukY+Cyg0RzpSkMp+xi6O/ycI/iX/9T29/RjI6DVLp6VDrplc+6+Pt
         6lMCc6K6hxvs7Bvhe2EpTFqLghO1T11jf5WrAm9nHeWnC6zBjvH8+KfVWwGqM3tRO0wA
         NEvgZgP4aUvLx65o/ENJJ8V8uHLih1uWJkUMJAXr2bYVs3b+HU8nWULLfSCyQ5fr/hjs
         gRQW/bOKJp6T290t9dySexORR642icHDg9zrCLcSXOT5PyZzOvZA90+nCCYepGZWOjfM
         E46A==
X-Gm-Message-State: ABy/qLZmajyWVzGooB6UcjGlEiK48pVLJ7O9qJhvYmii3XeHAerhL9kI
        G+b5xAQoMv022op1kwWz+je3mofA6/EhkylVzSYwQA==
X-Google-Smtp-Source: APBJJlHLONYvTW7m5Fbx16RlTb/fOqinzIvyTzihLXJQXLhrTmtvBuSogp90ZclD7PbARqJZdKXYR/WVY9tuMb+Y5tE=
X-Received: by 2002:a17:906:292:b0:97e:17cc:cc95 with SMTP id
 18-20020a170906029200b0097e17cccc95mr3045374ejf.36.1689787326540; Wed, 19 Jul
 2023 10:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-13-seanjc@google.com>
In-Reply-To: <20230718234512.1690985-13-seanjc@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Wed, 19 Jul 2023 10:21:55 -0700
Message-ID: <CAGtprH9a2jX-hdww9GPuMrO9noNeXkoqE8oejtVn2vD0AZa3zA@mail.gmail.com>
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 18, 2023 at 4:49=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> ...
> +static int kvm_gmem_error_page(struct address_space *mapping, struct pag=
e *page)
> +{
> +       struct list_head *gmem_list =3D &mapping->private_list;
> +       struct kvm_memory_slot *slot;
> +       struct kvm_gmem *gmem;
> +       unsigned long index;
> +       pgoff_t start, end;
> +       gfn_t gfn;
> +
> +       filemap_invalidate_lock_shared(mapping);
> +
> +       start =3D page->index;
> +       end =3D start + thp_nr_pages(page);
> +
> +       list_for_each_entry(gmem, gmem_list, entry) {
> +               xa_for_each_range(&gmem->bindings, index, slot, start, en=
d - 1) {
> +                       for (gfn =3D start; gfn < end; gfn++) {
> +                               if (WARN_ON_ONCE(gfn < slot->base_gfn ||
> +                                               gfn >=3D slot->base_gfn +=
 slot->npages))
> +                                       continue;
> +
> +                               /*
> +                                * FIXME: Tell userspace that the *privat=
e*
> +                                * memory encountered an error.
> +                                */
> +                               send_sig_mceerr(BUS_MCEERR_AR,
> +                                               (void __user *)gfn_to_hva=
_memslot(slot, gfn),
> +                                               PAGE_SHIFT, current);

Does it make sense to replicate what happens with MCE handling on
tmpfs backed guest memory:
1) Unmap gpa from guest
2) On the next guest EPT fault, exit to userspace to handle/log the
mce error for the gpa.

IIUC, such MCEs could be asynchronous and "current" might not always
be the intended recipient of this signal.

> +                       }
> +               }
> +       }
> +
> +       filemap_invalidate_unlock_shared(mapping);
> +
> +       return 0;
> +}
> +
