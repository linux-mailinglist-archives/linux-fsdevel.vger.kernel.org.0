Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C570627D27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 12:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbiKNL5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 06:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbiKNL5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:57:11 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B76720BDE
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 03:54:13 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id t1so7304902wmi.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 03:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFrv/gZh3M5M+GHa7rgQfMzZBcJfOT6Htd7GIwYXDjY=;
        b=EUoeLavTVlHYdJZCNph9EHvSI+oEmosznJ6f/upKgsdxBCVKAD+wKTTxF2HefZF4aJ
         +voBzLkimQpEK0QSkfAiC1ct7gmCt04TDRoYbiQk2+ZrURn8qyzn7B8NaLHEY4CnDGm6
         2jfadRSEAwkAURqUwVqJzHS0olixUeaFGq8/b2tw1FpYy5tfyimf03hvtmiBkAGD8Dwl
         b0COvNcSFazcgu2nDWFiq0ZFNQbDFye/UqRwXqYAyjzv+ihl5HvLX0qY0nWmYQKPF5Em
         ZwJAftOJ9dK9vLfL3ce4f68mG7VbwAJZ0JD+C1zsDfb08VanEK8T+D9r6Jo/S49b7wiV
         j91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UFrv/gZh3M5M+GHa7rgQfMzZBcJfOT6Htd7GIwYXDjY=;
        b=UF1HIkUPX+pnL9oIDVUpgoKan1Gfahc9za0g/FRdiVC9QI7NUJ9C51JfM3Hhl1YyML
         vzV2F3EGMaRpaVAF1f0pEzlscg45XzANbrLXS6aWJqXPfOiUijxVT5BS7kwJEzknzq2v
         PnINoW9+ivcYzSVEAbvnQNJ6ofAFXWlmZDTXhSBHU2ZZ3Ue6cMtrH4XSLErSwYYpii+d
         W971vO0z1XO3nO/GkVmV/+CDruOs2RejBLtTYXeXjKMDW1mTWPDfKmwSQUGbt/ZVfOdn
         xzHOPnZPaSx7cLuyEgAAXOx317n2THz4Uipg4LAhWKi7p4tYSk069rBkEFNO9SBTtD+0
         aqTw==
X-Gm-Message-State: ANoB5pkxRcIJsEmvqeUUExO/aYUuBuV98Bo9AvIWqJEgxIMT78vcCBAH
        Oc49SxRlVawovO+TxR+qYHOryQ==
X-Google-Smtp-Source: AA0mqf403V0vwqaE+mnyncg76u8ir3wUv9Nm7KTIlaElnQNtqjHebbBnqedRs9sCRLI9w2BMk0/32Q==
X-Received: by 2002:a05:600c:2315:b0:3cf:ae53:918f with SMTP id 21-20020a05600c231500b003cfae53918fmr7727329wmo.131.1668426851811;
        Mon, 14 Nov 2022 03:54:11 -0800 (PST)
Received: from zen.linaroharston ([185.81.254.11])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb11000000b002417f35767asm6097766wrr.40.2022.11.14.03.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 03:54:11 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 5E6971FFB7;
        Mon, 14 Nov 2022 11:54:10 +0000 (GMT)
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
User-agent: mu4e 1.9.2; emacs 28.2.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
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
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v9 0/8] KVM: mm: fd-based approach for supporting KVM
Date:   Mon, 14 Nov 2022 11:43:37 +0000
In-reply-to: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
Message-ID: <87k03xbvkt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Chao Peng <chao.p.peng@linux.intel.com> writes:

<snip>
> Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> KVM userspace being able to crash the host is horrible. Under current
> KVM architecture, all guest memory is inherently accessible from KVM
> userspace and is exposed to the mentioned crash issue. The goal of this
> series is to provide a solution to align mm and KVM, on a userspace
> inaccessible approach of exposing guest memory.=20
>
> Normally, KVM populates secondary page table (e.g. EPT) by using a host
> virtual address (hva) from core mm page table (e.g. x86 userspace page
> table). This requires guest memory being mmaped into KVM userspace, but
> this is also the source where the mentioned crash issue can happen. In
> theory, apart from those 'shared' memory for device emulation etc, guest
> memory doesn't have to be mmaped into KVM userspace.
>
> This series introduces fd-based guest memory which will not be mmaped
> into KVM userspace. KVM populates secondary page table by using a
> fd/offset pair backed by a memory file system. The fd can be created
> from a supported memory filesystem like tmpfs/hugetlbfs and KVM can
> directly interact with them with newly introduced in-kernel interface,
> therefore remove the KVM userspace from the path of accessing/mmaping
> the guest memory.=20
>
> Kirill had a patch [2] to address the same issue in a different way. It
> tracks guest encrypted memory at the 'struct page' level and relies on
> HWPOISON to reject the userspace access. The patch has been discussed in
> several online and offline threads and resulted in a design document [3]
> which is also the original proposal for this series. Later this patch
> series evolved as more comments received in community but the major
> concepts in [3] still hold true so recommend reading.
>
> The patch series may also be useful for other usages, for example, pure
> software approach may use it to harden itself against unintentional
> access to guest memory. This series is designed with these usages in
> mind but doesn't have code directly support them and extension might be
> needed.

There are a couple of additional use cases where having a consistent
memory interface with the kernel would be useful.

  - Xen DomU guests providing other domains with VirtIO backends

  Xen by default doesn't give other domains special access to a domains
  memory. The guest can grant access to regions of its memory to other
  domains for this purpose.=20

  - pKVM on ARM

  Similar to Xen, pKVM moves the management of the page tables into the
  hypervisor and again doesn't allow those domains to share memory by
  default.

  - VirtIO loopback

  This allows for VirtIO devices for the host kernel to be serviced by
  backends running in userspace. Obviously the memory userspace is
  allowed to access is strictly limited to the buffers and queues
  because giving userspace unrestricted access to the host kernel would
  have consequences.

All of these VirtIO backends work with vhost-user which uses memfds to
pass references to guest memory from the VMM to the backend
implementation.

> mm change
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> Introduces a new memfd_restricted system call which can create memory
> file that is restricted from userspace access via normal MMU operations
> like read(), write() or mmap() etc and the only way to use it is
> passing it to a third kernel module like KVM and relying on it to
> access the fd through the newly added restrictedmem kernel interface.
> The restrictedmem interface bridges the memory file subsystems
> (tmpfs/hugetlbfs etc) and their users (KVM in this case) and provides
> bi-directional communication between them.=20
>
>
> KVM change
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Extends the KVM memslot to provide guest private (encrypted) memory from
> a fd. With this extension, a single memslot can maintain both private
> memory through private fd (restricted_fd/restricted_offset) and shared
> (unencrypted) memory through userspace mmaped host virtual address
> (userspace_addr). For a particular guest page, the corresponding page in
> KVM memslot can be only either private or shared and only one of the
> shared/private parts of the memslot is visible to guest. For how this
> new extension is used in QEMU, please refer to kvm_set_phys_mem() in
> below TDX-enabled QEMU repo.
>
> Introduces new KVM_EXIT_MEMORY_FAULT exit to allow userspace to get the
> chance on decision-making for shared <-> private memory conversion. The
> exit can be an implicit conversion in KVM page fault handler or an
> explicit conversion from guest OS.
>
> Extends existing SEV ioctls KVM_MEMORY_ENCRYPT_{UN,}REG_REGION to
> convert a guest page between private <-> shared. The data maintained in
> these ioctls tells the truth whether a guest page is private or shared
> and this information will be used in KVM page fault handler to decide
> whether the private or the shared part of the memslot is visible to
> guest.
>
<snip>

--=20
Alex Benn=C3=A9e
