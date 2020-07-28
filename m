Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8A1230C4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 16:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgG1OXI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 10:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbgG1OXH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:23:07 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7151DC061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 07:23:07 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x9so9972709plr.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=0gezrYAszKsYKcLXi9TMmF45AfpArZp7tf2tQTcsIB4=;
        b=D7/86MC1Tqp9oc0VICIhfafxb3tBKrlVgTQgo74JcMWGNVZjzmkRkSPO+UaELTUEwa
         hA2GW+HERh5M2odXF3L1QZNAFFoTOnxCUqDuUqd+xD54MgRqydkWiLasAWQmucuiUX9y
         /HA6vqfiAYDwCMBvJQPsnzD96xliQ3O0e++hOjll/2Z5APzOuNu7gH9zfRs4jk1u/4VI
         49V7Y+MZGeI3h+zO6gZkKACbWgKi3SBDGtM0OP0OKRBoHDlHCLafa/fTo8q2s2AnY2mL
         fhpECbWQwe8VhAil1beOIe84mykJJtKhpx/KmcnDNs3QlX6d51VI87/q+vivCNN/VjqH
         7mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=0gezrYAszKsYKcLXi9TMmF45AfpArZp7tf2tQTcsIB4=;
        b=aJv6rtfdj+truPhkoYGAwxiUBrSVp0mlnG6GJ7K38LhXw7dleUcdMdInw5daWQxHm0
         DUy/iuCzNSU6+orxnvhKyAWJC85EdYqPPfpsbXKq4vIEOitCgJfym97mpr7I5oNb+E7J
         eytHeU4PHIlJ/L7K+ivZEecOIughAoYrRN8BJD2bn2waHmb1wO1g2GfyRwJObaUwOMdI
         7P6TLmjEuG3TMLweDz8/seHuLRwr9OwmlZxHht77ksslWcQ4uFzVYiamMKVD6aOPKYZ8
         4KttsduyotCGkC7HV+fuY+qEYYuuNnRsQX5lmwEp9kPGcnLEDKrWCif780Tvm+I0Zufj
         5KXA==
X-Gm-Message-State: AOAM533Nmn2z/Znw0voPgW0lEKtRnr51SS5b36Ft7ewEPm2nh3jzJjoY
        /64J366rxw6yBvXpbm+qp4QkIA==
X-Google-Smtp-Source: ABdhPJwGmlsbEVuJXdrA5FyCMv/IW/fPnSTAHwkj6VyQa14OnWq1IW5Sje+yw0TWIJZrFoMkdQtvhw==
X-Received: by 2002:a17:90a:ce0c:: with SMTP id f12mr4957417pju.19.1595946186974;
        Tue, 28 Jul 2020 07:23:06 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:1c3a:e74b:bd16:b3ab? ([2601:646:c200:1ef2:1c3a:e74b:bd16:b3ab])
        by smtp.gmail.com with ESMTPSA id 4sm18047374pgk.68.2020.07.28.07.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 07:23:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date:   Tue, 28 Jul 2020 07:23:03 -0700
Message-Id: <1764B08C-CC1E-4636-944A-DB95B81C7A8E@amacapital.net>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        gerg@linux-m68k.org, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me,
        areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com
In-Reply-To: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 27, 2020, at 10:02 AM, Anthony Yznaga <anthony.yznaga@oracle.com> w=
rote:
>=20
> =EF=BB=BFThis patchset adds support for preserving an anonymous memory ran=
ge across
> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for=

> sharing memory in this manner, as opposed to re-attaching to a named share=
d
> memory segment, is to ensure it is mapped at the same virtual address in
> the new process as it was in the old one.  An intended use for this is to
> preserve guest memory for guests using vfio while qemu exec's an updated
> version of itself.  By ensuring the memory is preserved at a fixed address=
,
> vfio mappings and their associated kernel data structures can remain valid=
.
> In addition, for the qemu use case, qemu instances that back guest RAM wit=
h
> anonymous memory can be updated.

This will be an amazing attack surface. Perhaps use of this flag should requ=
ire no_new_privs?  Arguably it should also require a special flag to execve(=
) to honor it.  Otherwise library helpers that do vfork()+exec() or posix_sp=
awn() could be quite surprised.

