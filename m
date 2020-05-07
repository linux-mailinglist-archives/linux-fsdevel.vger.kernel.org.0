Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073A11C9E3E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 00:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgEGWHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 18:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgEGWHo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 18:07:44 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C88C05BD0A
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 15:07:44 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w29so6280566qtv.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 15:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=en4GHRy/JYPyqA5v6A21rwrH4iUeiYDglj3PCm7zaTE=;
        b=NsTphQo3KrIot3EHRR9MKfhiB8/WsOHq01/hLgkb+H//7PrOqvCj5NTxbnaFUnfyCm
         0iwuvrNpoPVetfRb67BNbjybK6/uoNcUveymSiiNlXA45tEK0EtsQ5rzNJPrjzwGfrNZ
         RYuwS6foMYX9JtD8p/lE+cd5djCyYEqiAn3kIIyUNO+d5VF1/CTPg8jdMFLrI6/DZ95k
         OEh0TDXAiOnZ7ahcPGDPGCQcFv2LK27gK0aLjSyXsAk46ZO2MfZ0r/v4SpluZNwKJAUM
         2mQyVIqlXMDWClY69c2WULVjuPG+YFgSDAi+ZsWeevurvhZ45jn6p8zAOo30BIB1h9Sa
         LxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=en4GHRy/JYPyqA5v6A21rwrH4iUeiYDglj3PCm7zaTE=;
        b=gtqYDXtWgwNM4fF0u4Q7RxiCg0omVfbDl+4ThSlh+CZ3xE/0ktcbG3N17WAH1AE383
         4CnpU7F91tR2QsoqhjbXhWw3YTF5dcOgIPkpuU6EjBxDNOYixPTBXsMxk0QjzFLSaZjR
         v6OxK3b74NbDCbx70800gyH9/Hd5dAXNvpnCwUd3QbaF934MWrik0h3XWJES5d/Lyqnt
         Yp/DlGQQkOBEYyXMKVLNKtffL/hVxMk/BzBLMakO+EMVsB/SmMxoCeUeAnda2dPtxg26
         4AwRFPXvgcheSjXHdykfBdXcKuKxQNDkS84dGQKBal5PeT/zEXW9rNmB25w7UN8drqzE
         aU2g==
X-Gm-Message-State: AGi0PubND1T5s7dLmBptuHhLiyD2hycN4OzLO3yTBP/uENBSlONSyBkl
        pLfxoIsB7raZKOBnf9Yp9lrLtg==
X-Google-Smtp-Source: APiQypLmtknqWg6mIBNX7BYpFLD0P6MpzAP9oT8r+HqSraCfQP4KlBhA65zzanXtvuiNlwwIZjxRSw==
X-Received: by 2002:aed:2dc1:: with SMTP id i59mr16899053qtd.182.1588889263247;
        Thu, 07 May 2020 15:07:43 -0700 (PDT)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 10sm6045321qtp.4.2020.05.07.15.07.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 15:07:42 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] kernel: add panic_on_taint
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200507204219.GJ205881@optiplex-lnx>
Date:   Thu, 7 May 2020 18:05:27 -0400
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, Baoquan He <bhe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <27AA744E-930A-492A-BE87-05A119FE1549@lca.pw>
References: <20200506222815.274570-1-aquini@redhat.com>
 <C5E11731-5503-45CC-9F72-41E8863ACD27@lca.pw>
 <20200507204219.GJ205881@optiplex-lnx>
To:     Rafael Aquini <aquini@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 7, 2020, at 4:42 PM, Rafael Aquini <aquini@redhat.com> wrote:
>=20
> On Wed, May 06, 2020 at 10:50:19PM -0400, Qian Cai wrote:
>>=20
>>=20
>>> On May 6, 2020, at 6:28 PM, Rafael Aquini <aquini@redhat.com> wrote:
>>>=20
>>> Analogously to the introduction of panic_on_warn, this patch
>>> introduces a kernel option named panic_on_taint in order to
>>> provide a simple and generic way to stop execution and catch
>>> a coredump when the kernel gets tainted by any given taint flag.
>>>=20
>>> This is useful for debugging sessions as it avoids rebuilding
>>> the kernel to explicitly add calls to panic() or BUG() into
>>> code sites that introduce the taint flags of interest.
>>> Another, perhaps less frequent, use for this option would be
>>> as a mean for assuring a security policy (in paranoid mode)
>>> case where no single taint is allowed for the running system.
>>=20
>> Andrew, you can drop the patch below from -mm now because that one is =
now obsolete,
>>=20
>> mm-slub-add-panic_on_error-to-the-debug-facilities.patch
>>=20
> Please, don't drop it yet. I'll send a patch to get rid of the bits,
> once this one gets accepted, if it gets accepted.

Why do you ever want that obsolete patch even show up in linux-next to =
potentailly waste other people/bots time to test it and develop things =
on top of it?=
