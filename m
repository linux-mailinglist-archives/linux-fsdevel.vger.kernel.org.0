Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02394769C47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 18:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjGaQYN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 12:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjGaQYM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:24:12 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5D9E78
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 09:24:10 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-63d2b7d77bfso34603546d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 09:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690820650; x=1691425450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bBibAebd9TH21iCDO05hSEk2osKPAFkgUcjQOZN6IE=;
        b=Nxq6zpIl4t0T0IKgYCttihPgWkXDGg2v82UeoDRuJEPiuoZCcaCHDZLE9kkIxiKoGj
         jk+IsC1Guj9oI8nO++cnUqPSWZhSmAdBVc5lsM1hT0kSe4RC/KjMhhSc6wlqkqU2YaQ2
         MlzhwgMrC6YuHdeNmM0ceLnhR0bBMJIyRtICLHnduD/dx0KJOUH8SaivN46+P6VL/13o
         HD2+rdmaVCfzWB1fiLuejcoL89Z+FWgZTnHkXXYaDxZvnDyh2EIFMo2Vuj5jGb8JG448
         0UmR6aeSUdj4a9FGESdjj1akt6y1FHupeca6JLTCIL1tXPbyPZc4VruR8nQPmlFHhYMX
         m2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690820650; x=1691425450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bBibAebd9TH21iCDO05hSEk2osKPAFkgUcjQOZN6IE=;
        b=VK+ni6FlhzsEKSfF6zozUQ7CD+pk70+1VMGWW9/nXoInNtXukT7Ug0oUVTyIAqqgPY
         4ZkA+2UMLOrGpUu+xhX+p+zMj/zvkThCfiSlmKhTMqrl9sGTI4IfzogXr1PflDhlUCmM
         yUfE+rPfRLS/sX/CfCGyjyruxx9qPVWkN8vDjeUu7DtRjENGSBUL3lXWOoBKdJrxQveR
         F83jcn+AABIzCvCY4si6HMReRKYvGCk5RXk9Md6x+5eBtXrI8cOu0dY12VSnIuCDEaEY
         rmo/qhF7CE1S5BgWirpPEvxH/gjN1gQ1zH87EyDOSmAMJBhLlk8OAuMfkm7ERl4YkoHO
         wKCA==
X-Gm-Message-State: ABy/qLYWlAXb9d2df+Xu3KN8fziQTroxX7uoONMvzGNy+ZRWXS5jeOh8
        1l34IYoICK5mjvD0gGhJ9NlbU9jMNpRu+1bJQ81mfQ==
X-Google-Smtp-Source: APBJJlHREYUxXxwX9gGy7EcKK3cJKFiEBqZ2OxDI6ULebXBrqt9zCYKQ0hqOpLlGDOWyAd0KbYFFLQMR5e4GSI0P8JE=
X-Received: by 2002:a0c:ef0a:0:b0:63d:281d:d9cd with SMTP id
 t10-20020a0cef0a000000b0063d281dd9cdmr11195773qvr.57.1690820649949; Mon, 31
 Jul 2023 09:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-13-seanjc@google.com>
 <DS0PR11MB637386533A4A10667BA6DF03DC03A@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZL/yb4wL4Nhf9snZ@google.com>
In-Reply-To: <ZL/yb4wL4Nhf9snZ@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 31 Jul 2023 17:23:33 +0100
Message-ID: <CA+EHjTwGoMgoTEktL9zq2190TMY=vU29xv+oQ7X2Eeu8c8AmjQ@mail.gmail.com>
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
To:     Sean Christopherson <seanjc@google.com>
Cc:     Wei W Wang <wei.w.wang@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
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
        "Serge E. Hallyn" <serge@hallyn.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Sean,

On Tue, Jul 25, 2023 at 5:04=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Jul 25, 2023, Wei W Wang wrote:
> > On Wednesday, July 19, 2023 7:45 AM, Sean Christopherson wrote:
> > > +int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> > > +                gfn_t gfn, kvm_pfn_t *pfn, int *max_order) {
> > > +   pgoff_t index =3D gfn - slot->base_gfn + slot->gmem.pgoff;
> > > +   struct kvm_gmem *gmem;
> > > +   struct folio *folio;
> > > +   struct page *page;
> > > +   struct file *file;
> > > +
> > > +   file =3D kvm_gmem_get_file(slot);
> > > +   if (!file)
> > > +           return -EFAULT;
> > > +
> > > +   gmem =3D file->private_data;
> > > +
> > > +   if (WARN_ON_ONCE(xa_load(&gmem->bindings, index) !=3D slot)) {
> > > +           fput(file);
> > > +           return -EIO;
> > > +   }
> > > +
> > > +   folio =3D kvm_gmem_get_folio(file_inode(file), index);
> > > +   if (!folio) {
> > > +           fput(file);
> > > +           return -ENOMEM;
> > > +   }
> > > +
> > > +   page =3D folio_file_page(folio, index);
> > > +
> > > +   *pfn =3D page_to_pfn(page);
> > > +   *max_order =3D compound_order(compound_head(page));
> >
> > Maybe better to check if caller provided a buffer to get the max_order:
> > if (max_order)
> >       *max_order =3D compound_order(compound_head(page));
> >
> > This is what the previous version did (restrictedmem_get_page),
> > so that callers who only want to get a pfn don't need to define
> > an unused "order" param.
>
> My preference would be to require @max_order.  I can kinda sorta see why =
a generic
> implementation (restrictedmem) would make the param optional, but with gm=
em being
> KVM-internal I think it makes sense to require the param.  Even if pKVM d=
oesn't
> _currently_ need/want the order of the backing allocation, presumably tha=
t's because
> hugepage support is still on the TODO list, not because pKVM fundamentall=
y doesn't
> need to know the order of the backing allocation.

You're right that with huge pages pKVM will eventually need to know
the order of the backing allocation, but there is at least one use
case where it doesn't, which I ran into in the previous ports as well
as this one. In pKVM (and in possibly other implementations), the host
needs to access (shared) guest memory that isn't mapped. For that,
I've used kvm_*_get_pfn(), only requiring the pfn, so get the page via
pfn_to_page().

Although it's not that big, my preference would be for max_order to be opti=
onal.

Thanks!
/fuad
