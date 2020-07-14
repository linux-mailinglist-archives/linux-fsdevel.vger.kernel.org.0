Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2602A21F7BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 18:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgGNQ5d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 12:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbgGNQ5c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:57:32 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B766C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 09:57:32 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id g13so13325317qtv.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3Vl7lXSBLWRQLzjq6qw4dXugUjlNDno9t87QTaRNu0=;
        b=e/jd97eWsfnhXcOfbPxvUA+fSF6vtBv9lA2qsuFpBKBa+cOOL77M+iMH8yFXaNsJKM
         Z7G7MftWez2ilmY0eZMxzC1Xn6tkUvmGfwRoiV3wUUShWTPO5q0DW/yl6kngEVX+a5Rq
         KKUNV6+wv1M673kR4ubROjD2V5KsZqu5lm688PDuSQQf+LsCra1jAQ1jdZVNG9IBkwkj
         J+ApKuOnrfukqsYJeuVtFdcmtFxBmZoCoIo8TJ9FQGlTaliSz0gKQv8Mvk7fE8gHJi+U
         wQa7i1j22EXT6qdoSRnnj68US5iux5SBGzJbhjjtGbL5j8TiBbm7wmOo4ee7Wz8snecW
         Ln7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3Vl7lXSBLWRQLzjq6qw4dXugUjlNDno9t87QTaRNu0=;
        b=SnOOZxnr3aq76Azf683NKhTD7PXBxRz0zLCcx1qt1VGUwto0SHFYpduDNP3ZbIsX6U
         C/PKTD00MFvYbvjRfX92i6boezUe6saVWC39ZgD5MbkFOBVds5TqANiKvcebtBXZbEpR
         Akc5/UOwHMB16Xjp7Eva0M6SERCDeIwBjXyDJlVj+NXcDLL4QolYDMfmQMR/xL9vWZ+y
         7HHoSeHqfpw/yY3WSgs7PEBtEwfBIJlVDXKCFC6jKO6h2HWvbZMXEA2/dtAtgHN9vGR8
         Aa+RbdFLQ0xxlFFhqM8mEKj6xhtQCyvHTcjd8CgobgZjyuwR0CTf/Eaecs6ZqjiKwa8F
         iMrg==
X-Gm-Message-State: AOAM530WKKtiCSCpt6wNic/h2I/0HO/AsAgylcpH9GEboEO3vHU0+Gef
        kcxkHYQH/FZJfhlcMNQZOCt1EwG4UzAZarwxS9lQcK7Q
X-Google-Smtp-Source: ABdhPJw0CD9SLAjxqsroSJ51+sFvUvuFOAqdYaR2xPOV6t+zCv5g0MwJt8rFds99Lanqzk82SvaygXSshoV8Ip7EuuA=
X-Received: by 2002:ac8:6989:: with SMTP id o9mr5851059qtq.50.1594745851384;
 Tue, 14 Jul 2020 09:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200714025417.A25EB95C0339@us180.sjc.aristanetworks.com> <20200714131413.GJ23073@quack2.suse.cz>
In-Reply-To: <20200714131413.GJ23073@quack2.suse.cz>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Tue, 14 Jul 2020 09:57:18 -0700
Message-ID: <CA+HUmGhSMtus0-a5Z75zu2GUGce6GhSks8ATDQK2h7CiNRFmpA@mail.gmail.com>
Subject: Re: soft lockup in fanotify_read
To:     Jan Kara <jack@suse.cz>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, amir73il@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for the replies and workaround suggestions!

Francesco
