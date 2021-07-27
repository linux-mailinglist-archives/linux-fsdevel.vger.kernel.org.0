Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4370F3D73A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 12:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbhG0Ktz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 06:49:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50110 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbhG0Kty (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:49:54 -0400
Date:   Tue, 27 Jul 2021 12:49:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627382993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pnuEkaTi5KmPTs5VT/o5meVB3LCybBgbK1WW2inO8Gc=;
        b=VhLVARQKG0vDSZIJSDL2YB/k8YfUlLFNHw4ymeK0XG5yI4LqJZ3oguVDjEcVDeAX5hss3J
        CjFIO8FRijIIb8sqbE08RHMc/TPkx9UmTPMQ96yeAAlSc9wcNwyygZV9A2t6sKdU+37tGk
        pxya5iuGLvxhtVIC/wOENQXIhwwFkVN1HUauHtO1su0l/brGjIiAjzayQWmDArecPJQcMM
        2Ca3tOK9JtjyFCQxBXbwXZTzGMMXHqeg7pDibTglTU5XxIds4/sWhlMRzBFP6hkHD9l8wd
        psSm2D6TNgVdTU9lHWRSFLQtTNdG5DUKPpwoxAusbHMj+rSyFGcutN0Iafgz4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627382993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pnuEkaTi5KmPTs5VT/o5meVB3LCybBgbK1WW2inO8Gc=;
        b=M+JmuLl6V3FX9IFwC/okw7XfSTA6D1ENpvXykS447NXI4zZ+unYER6VXKGzEXI+LTJxqzR
        nlN4Ozo47Yblw/CA==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jordy Zomer <jordy@pwning.systems>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] fs: make d_path-like functions all have unsigned size
Message-ID: <YP/k0Nn/UnaKiKq2@lx-t490>
References: <20210727103625.74961-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727103625.74961-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021, Greg Kroah-Hartman wrote:
>
> Resolve all of the abuguity by just making "size" an unsigned value,
> which takes the guesswork out of everything involved.
>

Pardon my ignorance, but why not size_t instead of an unsigned int? I
feel it will be more clear this way; but, yes, on 64-bit machines this
will extend the buflen param to 64-bit.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
