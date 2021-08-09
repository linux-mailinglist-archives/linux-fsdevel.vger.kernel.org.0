Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BCB3E4E18
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 22:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbhHIUtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 16:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhHIUtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 16:49:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A1EC0613D3;
        Mon,  9 Aug 2021 13:49:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id b6so20335883lff.10;
        Mon, 09 Aug 2021 13:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xkmU2JA6zfghnyY/Y5tK7LzUc0w134KqplhtslWkECA=;
        b=mZ4Sa4Cy9nZtqeAfq7Jkmya1uATv8yy7EhGkJDk80lfWc+kfkFvZ+WSdNqlGqWU81q
         zkpYWkyu5QIVhZd7MQA4fN7PEP9wrJtENPvxVQ4TL21YYUoQMD//o1aRzQ6Kw8Zrrlh7
         YcCHQFvDgfJQcMl7AeVcYtcikwVth+OjoiE2l64jnhD6eAcnFIHyF/8cI5Spd9P4TtTZ
         kfU2dysvfQmgG6RYX+Q6eaxVBMjYRqK1WQVEU6tUZ6OZeetbA0ATyJaw0uBHWPkjbBkg
         /8e3eKj72qySizLS6C0zqsnXZR2aUdI+JSlw9gs2XExPzIZmPbXdTE3zslzjZ+vNTrZV
         4r6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xkmU2JA6zfghnyY/Y5tK7LzUc0w134KqplhtslWkECA=;
        b=IXarqf1bUlsuNgI+TlzpZsJ/SCESKWp+KnAodhxR1KJIE/mFZKArJeVSU4RimRjHB4
         cr/JNm4BuKBTUl7vefVVXAXaTQb36fVUIiDug7q1SfTTiGQfwStRJNsZoYijWGz/dZP8
         sa9A7QoMZUs4fo/jhcK6b5uoFpYOUsXBen4AEEFCvcL+Wlu7q3hHAa8WuQGGoyHgB5BA
         l4Wee35DO7x3plnW5t7c/qqXcw22cG5wilXBnXUT30V/C5HKisKOTwYw9Z3AMmPplngb
         wQ+9XbnARRvAIkE+VAOW/tJxsf5wux4ILUi3C6aDyAAwn6gJUXsKCF8tGgvM9lWdUOba
         MlEQ==
X-Gm-Message-State: AOAM530igVoHSB1SL2HtF20c1+JJWxxfl/hTn8YHRm0Ydto9M4G6rci5
        Ch2lNpFrUXaspak4/bs1ibw=
X-Google-Smtp-Source: ABdhPJxDrhRAL27eit/VPKKI/hfTq1DZqCIZJjVrBY/8+bt4lqWFglWjlHsmgCisMCi3e3gqdpd18A==
X-Received: by 2002:a19:6403:: with SMTP id y3mr4789111lfb.120.1628542164006;
        Mon, 09 Aug 2021 13:49:24 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id h18sm297957lfu.180.2021.08.09.13.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 13:49:23 -0700 (PDT)
Date:   Mon, 9 Aug 2021 23:49:21 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 02/20] hfsplus: Add iocharset= mount option as alias
 for nls=
Message-ID: <20210809204921.3ovrnbtzywsui4pt@kari-VirtualBox>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-3-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210808162453.1653-3-pali@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 08, 2021 at 06:24:35PM +0200, Pali Rohár wrote:
> Other fs drivers are using iocharset= mount option for specifying charset.
> So add it also for hfsplus and mark old nls= mount option as deprecated.

It would be good to also update Documentation/filesystems/hfsplus.rst.

