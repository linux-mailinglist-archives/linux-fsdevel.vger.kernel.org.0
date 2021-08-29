Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD503FAC80
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 17:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbhH2PTh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 11:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbhH2PTc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 11:19:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9890BC061760
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Aug 2021 08:18:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ia27so25386809ejc.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Aug 2021 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WMCQKvetI0XkPpqOn9T5HvUMfbn/ZoV4rfgKei7DRbQ=;
        b=AUUV3UubwIyhdd3QwL/BBxhZ19xpizfCaKyOw0a60FAYj9f66viJmJP7tYy41TL9Wo
         eNf6jSSenKzez1einuBFP0+fY9nxF6hdr1wO8rBa3ENpUIALSpb4xoQIe/FnGz9OdKr4
         akd3h/x4wweRLZcDu6qCobE/A7Z+xWpOUJyaSVSIMFFdmJFI1BFVv9+MTwOs3ranzCkd
         oGxztcxgF7GefWZbnqsGU98ezJNZs0M34yqlyXDBLekLrFowEkt6Te8nTfcICh1kqHvv
         hxVzVNp/aWF2NVcn274Ko4GkP2ceS0SC5ZOsxYWUhGAioPzZG9dDe5rsYQsNxZdwDVK5
         euJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WMCQKvetI0XkPpqOn9T5HvUMfbn/ZoV4rfgKei7DRbQ=;
        b=j9r+GyiYgfCsAjNo37ka9xsooj2SKeTtJ8ooL5IxRUOYvhfUajiJ3rZyIZ8X/QdsqA
         Mbi2LdOszpMnyo/cbOHBl+/Kdz9Z/PXMfqiV8Sd3vRmOfqtIe+1C7b17el5MxaDWSMD9
         k6Owe+JXNNPWb61GGXW4D4zy/EDHSs9D7D9tM3+CmI0HwTtdJHoWUYkAF1vJ6sFguvOY
         qk9+xrU4W5Nlq/1bIRsuYRzIH47TJgiyXThM79TbIf3xKFH95sNLcV32zU68gD5UA1YY
         CDVbUd6hz7HWpuzlXJuR4XieobVN8seeux0bjmQMsUelTa2Op97Dh2AL8aa6Adt6hRfL
         AuDQ==
X-Gm-Message-State: AOAM530i2NaM4gKst8ux0atH5AGLAmTVPBgwt8N0BCEB/HUlUXgf1V6v
        mVCasAYZZyqH1+Tbxyo90apvO4+LeYXXG6x34BJE
X-Google-Smtp-Source: ABdhPJzddDAP4GwVgg5xjP+pa+Pe/nyxAGXU1kyChZOijuG2A5i+rzFXA53gOJ+xW6ZKS9R2sDtfMTdkLKe1+YuoHoI=
X-Received: by 2002:a17:906:8597:: with SMTP id v23mr13342286ejx.178.1630250318016;
 Sun, 29 Aug 2021 08:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <162871480969.63873.9434591871437326374.stgit@olly>
 <20210824205724.GB490529@madcap2.tricolour.ca> <20210826011639.GE490529@madcap2.tricolour.ca>
 <CAHC9VhSADQsudmD52hP8GQWWR4+=sJ7mvNkh9xDXuahS+iERVA@mail.gmail.com>
 <20210826163230.GF490529@madcap2.tricolour.ca> <CAHC9VhTkZ-tUdrFjhc2k1supzW1QJpY-15pf08mw6=ynU9yY5g@mail.gmail.com>
 <20210827133559.GG490529@madcap2.tricolour.ca> <CAHC9VhRqSO6+MVX+LYBWHqwzd3QYgbSz3Gd8E756J0QNEmmHdQ@mail.gmail.com>
 <20210828150356.GH490529@madcap2.tricolour.ca>
In-Reply-To: <20210828150356.GH490529@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 29 Aug 2021 11:18:26 -0400
Message-ID: <CAHC9VhRgc_Fhi4c6L__butuW7cmSFJxTMxb+BBn6P-8Yt0ck_w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/9] Add LSM access controls and auditing to io_uring
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 28, 2021 at 11:04 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> I did set a syscall filter for
>         -a exit,always -F arch=b64 -S io_uring_enter,io_uring_setup,io_uring_register -F key=iouringsyscall
> and that yielded some records with a couple of orphans that surprised me
> a bit.

Without looking too closely at the log you sent, you can expect URING
records without an associated SYSCALL record when the uring op is
being processed in the io-wq or sqpoll context.  In the io-wq case the
processing is happening after the thread finished the syscall but
before the execution context returns to userspace and in the case of
sqpoll the processing is handled by a separate kernel thread with no
association to a process thread.

-- 
paul moore
www.paul-moore.com
