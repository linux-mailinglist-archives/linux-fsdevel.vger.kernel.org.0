Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B87B19F94D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 17:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgDFPyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 11:54:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45048 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbgDFPyI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:54:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so161030lji.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Apr 2020 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Npl54g1ItqpAme/2buCJ5Yu5mdmAHuNU9wsDMO3jye0=;
        b=H4p3L21IZ+E6Zf51TcjhGAy5KKt6jEvVABr7zIB8jRl0G2SuDYdEetPYUT+1ZxEWS6
         6DgxrfZ6KnN4+KFuLplobcwfZUamqs9zkVWbAh1hO2ee6JuLvqUGOXWlP1C2HoiCV4Fx
         R0dS7eJj7qE9B5xQZOSWZcZAPWfCpE9O+mXpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Npl54g1ItqpAme/2buCJ5Yu5mdmAHuNU9wsDMO3jye0=;
        b=a19m4U9WFWN7/lKSE6dSHtxlysui0+KD2K2lITctx0EaWK4xiSMj376T2eRlK8Jlh5
         CU4YtNM9duUExj373lFepU0/NIbOuBunrvDAilX2U8JuoK1Zd25uo1J0GO0AyNCPuA71
         hdeOiZRBsh9wgMASx2gSGJS01mrcDcY3GSkkSl6ORdWGWjHjW2Sziz+ANkWTHLWkt9BO
         EaNBI6WsY3bbiViIduyJhF0LxWYK6AVshYnMelRyVSVwagkyzdKq83TprvgRBCRwCN92
         5VLnloHyzLA93MXEX8oHKFGGaN17NQ5HavZwE8PgMJJGwUqmFqjndmK11SnF+c1JcDzN
         YSMA==
X-Gm-Message-State: AGi0PuaJ6MmeE/V6xIqCvTLKbHd2Aw/5vbfscKvXzUpiuNylbrSyzjw1
        CiE3wcCRZW7xKc7aUVAjV/7lQKWCWUc=
X-Google-Smtp-Source: APiQypKoO0mmTUnjJC+Zno0Jm9wtcnpgDHo0Y3i2XdsZpPTjtxJ7Db7DDKfcdZkISvVSAlGflwQNeA==
X-Received: by 2002:a2e:9c8:: with SMTP id 191mr12129062ljj.259.1586188445563;
        Mon, 06 Apr 2020 08:54:05 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id s30sm2777837lfc.93.2020.04.06.08.54.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 08:54:04 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id r24so219364ljd.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Apr 2020 08:54:04 -0700 (PDT)
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr12993787ljm.201.1586188444079;
 Mon, 06 Apr 2020 08:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200406110702.GA13469@nautica>
In-Reply-To: <20200406110702.GA13469@nautica>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Apr 2020 08:53:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
Message-ID: <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
Subject: Re: [GIT PULL] 9p update for 5.7
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 6, 2020 at 4:07 AM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> - Fix read with O_NONBLOCK to allow incomplete read and return
> immediately

Hmm. This is kind of special semantics (normally a POSIX filesystem
ignores O_NONBLOCK), but I guess it makes sense for a network
filesystem.

It might be worth a bti more documentation/commenting because of the
special semantics. For example, since you don't have 'poll()',
O_NONBLOCK doesn't really mean "nonblocking", it means "stop earlier"
if I read that patch right. You can't just return -EAGAIN because
there's no way to then avoid busy looping..

                Linus
