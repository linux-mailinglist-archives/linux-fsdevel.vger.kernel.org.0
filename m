Return-Path: <linux-fsdevel+bounces-40148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96689A1DA68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 17:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65FF161772
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 16:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49233155CB3;
	Mon, 27 Jan 2025 16:21:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E231384039;
	Mon, 27 Jan 2025 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994905; cv=none; b=ldgsWSnGQvEgjIrDmjdn7psa38LNU3Q7xdI6vzDEqtaLQMTLZeMCzoFH1sFpqsOoDzCLSTG5dgTG10FWzqI1OUfIWkQABcXSMxmWdLVODybktw5/4SJoPe17viBtNOwMQsgLh+/v/jt2ZUiJPQyCVzHvmRPp+WBe3voWzAjxw30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994905; c=relaxed/simple;
	bh=9zboAYYsia2n4IduI3z/U3t1jmKc8HJmonBTt/8Myc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SuawFIvMf44HSjNVX4cWHpPiI4rFTk6By7s5pwupxyzfIeBPy5CGYUzdhiLIYYX/MEbWAukEd29GjnWMaD0HVzhwILIiHeLX/4dd7r4ytKnDAwUKqNTs+W33ZEYeUUqQ+HCiEHmIMj2LxYAEAD5QjEbFe7ewmjSVCNM519qr3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-467a6ecaa54so40822321cf.0;
        Mon, 27 Jan 2025 08:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737994900; x=1738599700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45OoBPJoV8zGfJClLFYbCrAaSSdq0Hy4HHZ9q0U58K4=;
        b=KdCugZ6YBwqqHNL1xLet9gmq5xIDRo97D8W8hqokI/+/wVDoF02CTEAlSEjWF7DMMQ
         NFSaGdmWfPZnxv7zFoZQYaxqsjgbg3lnZahSHkIif38rQsKv7z6kq52LlnpjppdTZfFY
         GyMfAhEsunGP1Kac7L20B/yScUMgz7/GJ09MlW9d8XQo/qvj3keRUqCimUushTZhhw2m
         5ZqKaMfZ92pnkHSPcWD5Wu0RkwG5dDl3Akel4mLwLcdq1PNVGGkRD4lwePeTqe5JUQg4
         dbhI2bACW7sAReNF9m4SBs/DRKRUNDnlNmYVmQQ8WU5OZTGL+vRiQr74ltb5NUcdfbAM
         V1GQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+ddYyO+1rUmUB/KfrslxkpXIAfPN4iM8esjoK5SYZk/MHeUixaqJL4vR9SPsRbphmzfL0kbh/iMB6@vger.kernel.org, AJvYcCU1WakF9Nplj9zFmBvCH297LwBOpNLH7eLM3ll0++KpVckBQeE2wsZnuuIwCzB7DvQ71NGMzUi6XjIvcb2g@vger.kernel.org, AJvYcCWFlY7iP0a9QqgWQ3d8T/g3gUE5sKakB+8SXBEqgzUeDTuT+3JjGMyVQRt62U6a8mSqrnLteDDaIGkICSDx@vger.kernel.org
X-Gm-Message-State: AOJu0YxqYVdCBlIz/tPu05hVngEI7v2LTjm5ypMZsG0rIOLQrV2g5VPX
	+osniF0FUAVBIeP4qX6crCoZLUcPWEXbI93KgZUgZkfATm223PO/5raOswl9py8=
X-Gm-Gg: ASbGncsjPoWKk8jpS5nvc+4aPJ6ivcaKa0V8G7uHxM87aj1/VKTWn77CuVad1IGcwPk
	gVJbQiImEiKacoZW3eq20SzR6LIuGSVDpz4IsqrwGQC1NOnvxqo/xgZfhvV+pNipE+CoYAry+Is
	OExSztBv2m6gDcLA9mhjsxjMxnuxi6MNQDy2foiPieFml84n3nhD6csEjrTpI/r05bwdeq58rpk
	RZXuptc/xX2RXLbXQ6eRYwDSGUhjHBrBQ9uan+Wx2uEvMUQkWXg11itQmx/xDHTEaQ98wuVc5Fe
	ZKqBNim4B9/vkhG2FGSDxkk29H1u4RS+k+aEeDEkeOI=
X-Google-Smtp-Source: AGHT+IEU//eglgKBNLQafGMcPTTdPkcn01iNy1hchCAILCc/3V6z1Y0Yb5wy2qDJ/okZDUkB+jheUQ==
X-Received: by 2002:ac8:7fcb:0:b0:466:a51b:6281 with SMTP id d75a77b69052e-46e12a9a6c2mr609961921cf.26.1737994900305;
        Mon, 27 Jan 2025 08:21:40 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-864a9c176f0sm1962251241.23.2025.01.27.08.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 08:21:40 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-85c5a913cffso2613910241.0;
        Mon, 27 Jan 2025 08:21:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVzRcGM/+CnxEVdD+WSCuqxRWgQ57k0SFRqvUc7sWtVgCH48Oxx51Jcl9X3TqKe5FjA4aFJjBy2JT0N@vger.kernel.org, AJvYcCWY3VoJWgASw5xA/Qte1S627buC5gBX6/Zg4++IwUOFeZZ+M2DfqOgbmlS3Ti9crWjBNkQJpsjrQ5fTDhP2@vger.kernel.org, AJvYcCXjvlandxAcxF7gJylllFwkxUBOK7o9SEvCoq7WW8Ql2D3je715Q4jZuNhfT1hUp0CVa6d81tjKkcwhrQ5I@vger.kernel.org
X-Received: by 2002:a05:6102:370e:b0:4b1:1a24:e19c with SMTP id
 ada2fe7eead31-4b690bb53cbmr34951549137.7.1737994899878; Mon, 27 Jan 2025
 08:21:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218154613.58754-1-shikemeng@huaweicloud.com> <20241218154613.58754-3-shikemeng@huaweicloud.com>
In-Reply-To: <20241218154613.58754-3-shikemeng@huaweicloud.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Jan 2025 17:21:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU_bfadUO=0OZ=AoQ9EAmQPA4wsLCBqohXR+QCeCKRn4A@mail.gmail.com>
X-Gm-Features: AWEUYZm3QsghWJGgtE4-bBJDpa8L-HpWyQPtWRVnePo0_2YvMLY_Y47k7OF49o4
Message-ID: <CAMuHMdU_bfadUO=0OZ=AoQ9EAmQPA4wsLCBqohXR+QCeCKRn4A@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] Xarray: move forward index correctly in xas_pause()
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Hi Kemeng,

On Wed, 18 Dec 2024 at 07:58, Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> After xas_load(), xas->index could point to mid of found multi-index entry
> and xas->index's bits under node->shift maybe non-zero. The afterward
> xas_pause() will move forward xas->index with xa->node->shift with bits
> under node->shift un-masked and thus skip some index unexpectedly.
>
> Consider following case:
> Assume XA_CHUNK_SHIFT is 4.
> xa_store_range(xa, 16, 31, ...)
> xa_store(xa, 32, ...)
> XA_STATE(xas, xa, 17);
> xas_for_each(&xas,...)
> xas_load(&xas)
> /* xas->index = 17, xas->xa_offset = 1, xas->xa_node->xa_shift = 4 */
> xas_pause()
> /* xas->index = 33, xas->xa_offset = 2, xas->xa_node->xa_shift = 4 */
> As we can see, index of 32 is skipped unexpectedly.
>
> Fix this by mask bit under node->xa_shift when move forward index in
> xas_pause().
>
> For now, this will not cause serious problems. Only minor problem
> like cachestat return less number of page status could happen.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Thanks for your patch, which is now commit c9ba5249ef8b080c ("Xarray:
move forward index correctly in xas_pause()") upstream.

> --- a/lib/test_xarray.c
> +++ b/lib/test_xarray.c
> @@ -1448,6 +1448,41 @@ static noinline void check_pause(struct xarray *xa)
>         XA_BUG_ON(xa, count != order_limit);
>
>         xa_destroy(xa);
> +
> +       index = 0;
> +       for (order = XA_CHUNK_SHIFT; order > 0; order--) {
> +               XA_BUG_ON(xa, xa_store_order(xa, index, order,
> +                                       xa_mk_index(index), GFP_KERNEL));
> +               index += 1UL << order;
> +       }
> +
> +       index = 0;
> +       count = 0;
> +       xas_set(&xas, 0);
> +       rcu_read_lock();
> +       xas_for_each(&xas, entry, ULONG_MAX) {
> +               XA_BUG_ON(xa, entry != xa_mk_index(index));
> +               index += 1UL << (XA_CHUNK_SHIFT - count);
> +               count++;
> +       }
> +       rcu_read_unlock();
> +       XA_BUG_ON(xa, count != XA_CHUNK_SHIFT);
> +
> +       index = 0;
> +       count = 0;
> +       xas_set(&xas, XA_CHUNK_SIZE / 2 + 1);
> +       rcu_read_lock();
> +       xas_for_each(&xas, entry, ULONG_MAX) {
> +               XA_BUG_ON(xa, entry != xa_mk_index(index));
> +               index += 1UL << (XA_CHUNK_SHIFT - count);
> +               count++;
> +               xas_pause(&xas);
> +       }
> +       rcu_read_unlock();
> +       XA_BUG_ON(xa, count != XA_CHUNK_SHIFT);
> +
> +       xa_destroy(xa);
> +
>  }

On m68k, the last four XA_BUG_ON() checks above are triggered when
running the test.  With extra debug prints added:

    entry = 00000002 xa_mk_index(index) = 000000c1
    entry = 00000002 xa_mk_index(index) = 000000e1
    entry = 00000002 xa_mk_index(index) = 000000f1
    ...
    entry = 000000e2 xa_mk_index(index) = fffff0ff
    entry = 000000f9 xa_mk_index(index) = fffff8ff
    entry = 000000f2 xa_mk_index(index) = fffffcff
    count = 63 XA_CHUNK_SHIFT = 6
    entry = 00000081 xa_mk_index(index) = 00000001
    entry = 00000002 xa_mk_index(index) = 00000081
    entry = 00000002 xa_mk_index(index) = 000000c1
    ...
    entry = 000000e2 xa_mk_index(index) = ffffe0ff
    entry = 000000f9 xa_mk_index(index) = fffff0ff
    entry = 000000f2 xa_mk_index(index) = fffff8ff
     count = 62 XA_CHUNK_SHIFT = 6

On arm32, the test succeeds, so it's probably not a 32-vs-64-bit issue.
Perhaps a big-endian or alignment issue (alignof(int/long) = 2)?

> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -1147,6 +1147,7 @@ void xas_pause(struct xa_state *xas)
>                         if (!xa_is_sibling(xa_entry(xas->xa, node, offset)))
>                                 break;
>                 }
> +               xas->xa_index &= ~0UL << node->shift;
>                 xas->xa_index += (offset - xas->xa_offset) << node->shift;
>                 if (xas->xa_index == 0)
>                         xas->xa_node = XAS_BOUNDS;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

