Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39B168D981
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 14:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjBGNht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 08:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjBGNhs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:37:48 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0D421A3F;
        Tue,  7 Feb 2023 05:37:43 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so11494008wms.1;
        Tue, 07 Feb 2023 05:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cm28rj9Az0U5hMacFDsUKTaBeJjioQqU2J6dR3p92Tg=;
        b=ILJQRtgZd7lX16j/WA8Lj/dGEeLZFfn+iFir7u0IH2rDTltxSs1I8igEN+PwwhbPO2
         7oPURxm3NDk2RY3SNISQvtkRUUM3c5bE6h0zB2NCiojvedfiaS8DW5sG9d1Hcp1Q8tiv
         XOIeKIR8X0TsNR76X5xukwz7wjo5zEi2BG8BzOP+uN7HZPiGzvKTESqXoALG1gL1PhCF
         4Y5UczT+FChIudEsGThZjXUVcVxusV1u1x+N7shOtTig1S7d0i1mZxdNjg33uMScZWe6
         EdBRncMKieo77OitLf+bN8Tz0GahtSg5H7JnR1o+Thr8GwD/J9VUdlLmPmaWgcrbOU1s
         TzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cm28rj9Az0U5hMacFDsUKTaBeJjioQqU2J6dR3p92Tg=;
        b=Pu3S67pRR5C4XdzIPk5c4NMQfLOAVaPWjOf4/LH/0KcikVC60Xin5r/GPsRbo8/uuE
         RRVaRrSCi5DzDUYG9ZUIbrXQaz2zcf61wWOcoARm9EKTLNTbSMFNnAK1CKXSWTTYQDrG
         ZQhPoivhHd2NiwPvDsOJl5HRUP+8+rP19gq0da3Sue4QszswcZlkDv7g90gGv3LOBQVk
         ooMoiMJevCMD3npVfGZRWV+Dw1jkJeFAcB2mTsXtGKxWCN0eDYy0VipaF+I184IsLR1y
         2UjzRAVm2Dt5lkGLhskAF5hOvqvFnDprI85biWIlWFg2JSL9/MrvGzM92QiDKXiHB0iP
         vjng==
X-Gm-Message-State: AO0yUKWZBucs6b0b4sYH0GnId3H0mYJMmQCi5fNeLmYfVZPDaOGrZVQc
        NeE805P8A991YEWrGA/w00c=
X-Google-Smtp-Source: AK7set8RzcALzpamYdyKC4uDj9lXzPUP6SPGeGKJIRGB15faLUk1G6npuUQipZ/Ae90poRqUiAITHA==
X-Received: by 2002:a05:600c:a291:b0:3dc:55e6:fffd with SMTP id hu17-20020a05600ca29100b003dc55e6fffdmr3188847wmb.15.1675777062052;
        Tue, 07 Feb 2023 05:37:42 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600002c700b002be5bdbe40csm12128975wry.27.2023.02.07.05.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:37:41 -0800 (PST)
Date:   Tue, 7 Feb 2023 16:37:38 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     xen-devel@lists.xenproject.org
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maobibo <maobibo@loongson.cn>,
        Matthew Wilcox <willy@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: xen: sleeping in atomic warnings
Message-ID: <Y+JUIl64UDmdkboh@kadam>
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org>
 <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
 <Y+EupX1jX1c5BAHv@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+EupX1jX1c5BAHv@kadam>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are static checker warnings from Smatch.  The line numbers are
based on next-20230207.  To reproduce these warnings then you need to
have the latest Smatch from git and you need to rebuild the cross
function probably four times.  I have reviewed most of these and they
all seem valid to me.  I remember I reported some a while back but never
heard back.  https://lore.kernel.org/all/20210802144037.GA29540@kili/

regards,
dan carpenter

arch/x86/xen/p2m.c:189 alloc_p2m_page() warn: sleeping in atomic context
xen_create_contiguous_region() <- disables preempt
xen_destroy_contiguous_region() <- disables preempt
-> xen_remap_exchanged_ptes()
   -> set_phys_to_machine()
      -> xen_alloc_p2m_entry()
         -> alloc_p2m_pmd()
xen_alloc_p2m_entry() <duplicate>
            -> alloc_p2m_page()

drivers/xen/events/events_base.c:1213 bind_evtchn_to_irq_chip() warn: sleeping in atomic context
pvcalls_front_connect() <- disables preempt
pvcalls_front_accept() <- disables preempt
-> create_active()
   -> bind_evtchn_to_irqhandler()
      -> bind_evtchn_to_irqhandler_chip()
         -> bind_evtchn_to_irq_chip()

drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c:303 netxen_pcie_sem_lock() warn: sleeping in atomic context
netxen_nic_hw_write_wx_2M() <- disables preempt
netxen_nic_hw_read_wx_2M() <- disables preempt
-> netxen_pcie_sem_lock()

drivers/xen/xen-pciback/pci_stub.c:110 pcistub_device_release() warn: sleeping in atomic context
pcistub_get_pci_dev_by_slot() <- disables preempt
pcistub_get_pci_dev() <- disables preempt
-> pcistub_device_get_pci_dev()
   -> pcistub_device_put()
      -> pcistub_device_release()

drivers/xen/xen-scsiback.c:1016 __scsiback_del_translation_entry() warn: sleeping in atomic context
scsiback_del_translation_entry() <- disables preempt
scsiback_release_translation_entry() <- disables preempt
-> __scsiback_del_translation_entry()

drivers/xen/xen-scsiback.c:276 scsiback_free_translation_entry() warn: sleeping in atomic context
scsiback_del_translation_entry() <- disables preempt
scsiback_release_translation_entry() <- disables preempt
-> __scsiback_del_translation_entry()
   -> scsiback_free_translation_entry()

drivers/xen/events/events_base.c:1427 unbind_from_irq() warn: sleeping in atomic context
pvcalls_front_connect() <- disables preempt
pvcalls_front_accept() <- disables preempt
-> create_active()
   -> bind_evtchn_to_irqhandler()
      -> bind_evtchn_to_irqhandler_chip()
         -> unbind_from_irq()

drivers/xen/xenbus/xenbus_client.c:473 xenbus_alloc_evtchn() warn: sleeping in atomic context
pvcalls_front_connect() <- disables preempt
pvcalls_front_accept() <- disables preempt
-> create_active()
   -> xenbus_alloc_evtchn()

drivers/xen/xenbus/xenbus_client.c:321 xenbus_dev_error() warn: sleeping in atomic context
pvcalls_front_connect() <- disables preempt
pvcalls_front_accept() <- disables preempt
-> create_active()
   -> xenbus_free_evtchn()
      -> xenbus_dev_error()

drivers/xen/xenbus/xenbus_client.c:342 xenbus_dev_fatal() warn: sleeping in atomic context
pvcalls_front_connect() <- disables preempt
pvcalls_front_accept() <- disables preempt
-> create_active()
   -> xenbus_alloc_evtchn()
      -> xenbus_dev_fatal()

drivers/xen/xenbus/xenbus_client.c:494 xenbus_free_evtchn() warn: sleeping in atomic context
pvcalls_front_connect() <- disables preempt
pvcalls_front_accept() <- disables preempt
-> create_active()
   -> xenbus_free_evtchn()

drivers/xen/xenbus/xenbus_client.c:290 xenbus_va_dev_error() warn: sleeping in atomic context
pvcalls_front_connect() <- disables preempt
pvcalls_front_accept() <- disables preempt
-> create_active()
   -> xenbus_free_evtchn()
      -> xenbus_dev_error()
create_active() <duplicate>
-> xenbus_alloc_evtchn()
   -> xenbus_dev_fatal()
         -> xenbus_va_dev_error()

