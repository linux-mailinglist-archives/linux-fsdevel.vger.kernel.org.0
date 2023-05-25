Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445907116FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 21:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242713AbjEYTJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 15:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242698AbjEYTJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 15:09:07 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F4AA26E
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 11:58:30 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4f4c264f6c6so2875797e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 11:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685040955; x=1687632955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIsIFxmLlj97Nfx6D9vKSgsX1a6jDH3TwyPUkCdOSPQ=;
        b=WT09u53qif3WIwdxCgSJWQzf1l9cny0DkKe4EjPiY4aDLLMYuRUof/diC0L2cA/QUo
         r6OjYywMmQA+SYPv2pbkuEIB+QVWVVahAsbQqYlu3jYIvbxcgIc9mkp4GuNnr4LhyDVy
         cYz5FhIRipWME4lrFm+KOA1w4wUoPSUjLF4RA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685040955; x=1687632955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIsIFxmLlj97Nfx6D9vKSgsX1a6jDH3TwyPUkCdOSPQ=;
        b=A4qKqFgg8V0uAsMBIKd9RwBOKWv7wHXRlCVm1g+7AkKfUrOmguz70LoyG5I6szf5OU
         tIDZTq7pHBEa1j/09zhgXtRQzYF7JFxcpgYrzIRiB/PBaouFOLsSKSHAYUP3r8DMaVhN
         iqKmGzg56Lsq7qWcrUNNj9TKNPbmeS4RjtuafC4y0dpaDwsoxPLW9g7GZwNg06NWcExm
         XjZdUflGGtzbcCmeShrUC7w3jkv1HD2yMJfX7UOxO7nDGQG4NrSPByyPgkVcyy8OmTM9
         /CgI+8JV8LQpV8byCqO7uC4dp3TwdurihI10Zhj7beJ/4Cv1ggtnXqO1Inm7qRQAOsoy
         KORA==
X-Gm-Message-State: AC+VfDwQOQfdkAahLA+2fIfT7Q4RBJa15gyKKZ54DFpjWFxBASrO4GRG
        jcj1yruDbUDLL9l2dF60Gm3Ah1CNXn6Cm0UaH9NFvWxz
X-Google-Smtp-Source: ACHHUZ4DS0oVYaLvs6w+4O/kMK5Y7ozxLyf5AQ9lEqcnGy1GaDZmcInDl/bnLT8QDa2UU3TZYxJyZw==
X-Received: by 2002:ac2:51ad:0:b0:4f2:e145:7170 with SMTP id f13-20020ac251ad000000b004f2e1457170mr6905019lfk.11.1685040954767;
        Thu, 25 May 2023 11:55:54 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id v24-20020ac25618000000b004cb43eb09dfsm305834lfd.123.2023.05.25.11.55.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 11:55:54 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2af20198f20so9771661fa.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 11:55:54 -0700 (PDT)
X-Received: by 2002:a17:907:6d9e:b0:96f:4ee4:10d4 with SMTP id
 sb30-20020a1709076d9e00b0096f4ee410d4mr2465428ejc.43.1685040638863; Thu, 25
 May 2023 11:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230524213620.3509138-1-mcgrof@kernel.org> <20230524213620.3509138-2-mcgrof@kernel.org>
 <CAHk-=wjahcAqLYm0ijcAVcPcQAz-UUuJ3Ubx4GzP_SJAupf=qQ@mail.gmail.com>
 <CAHk-=wgKu=tJf1bm_dtme4Hde4zTB=_7EdgR8avsDRK4_jD+uA@mail.gmail.com> <ZG+kDevFH6uE1I/j@bombadil.infradead.org>
In-Reply-To: <ZG+kDevFH6uE1I/j@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 11:50:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWCDw58fZDLGYVqVC2ee-Zec25unewdHFp8syCZFumvg@mail.gmail.com>
Message-ID: <CAHk-=wgWCDw58fZDLGYVqVC2ee-Zec25unewdHFp8syCZFumvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/kernel_read_file: add support for duplicate detection
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>, hch@lst.de,
        brauner@kernel.org, david@redhat.com, tglx@linutronix.de,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, lennart@poettering.net,
        gregkh@linuxfoundation.org, rafael@kernel.org, song@kernel.org,
        lucas.de.marchi@gmail.com, lucas.demarchi@intel.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 11:08=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> Certainly on the track where I wish we could go. Now this goes tested.
> On 255 cores:
>
> Before:
>
> vagrant@kmod ~ $ sudo systemd-analyze
> Startup finished in 41.653s (kernel) + 44.305s (userspace) =3D 1min 25.95=
8s
> graphical.target reached after 44.178s in userspace.
>
> root@kmod ~ # grep "Virtual mem wasted bytes" /sys/kernel/debug/modules/s=
tats
>  Virtual mem wasted bytes       1949006968
>
>
> ; 1949006968/1024/1024/1024
>         ~1.81515418738126754761
>
> So ~1.8 GiB... of vmalloc space wasted during boot.
>
> After:
>
> systemd-analyze
> Startup finished in 24.438s (kernel) + 41.278s (userspace) =3D 1min 5.717=
s
> graphical.target reached after 41.154s in userspace.
>
> root@kmod ~ # grep "Virtual mem wasted bytes" /sys/kernel/debug/modules/s=
tats
>  Virtual mem wasted bytes       354413398
>
> So still 337.99 MiB of vmalloc space wasted during boot due to
> duplicates.

Ok. I think this will count as 'good enough for mitigation purposes'

> The reason is the exclusive_deny_write_access() must be
> kept during the life of the module otherwise as soon as it is done
> others can still race to load

Yes. The exclusion only applies while the file is actively being read.

> So with two other hunks added (2nd and 4th), this now matches parity with
> my patch, not suggesting this is right,

Yeah, we can't do that, because user space may quite validly want to
write the file afterwards.

Or, in fact, unload the module and re-load it.

So the "exclusion" really needs to be purely temporary.

That said, I considered moving the exclusion to module/main.c itself,
rather than the reading part. That wouild get rid of the hacky "id =3D=3D
READING_MODULE", and put the exclusion in the place that actually
wants it.

And that would allow us to at least extend that temporary exlusion a
bit - we could keep it until the module has actually been loaded and
inited.

So it would probably improve on those numbers a bit more, but you'd
still have the fundamental race where *serial* duplicates end up
always wasting CPU effort and temporary vmalloc space.

                   Linus
