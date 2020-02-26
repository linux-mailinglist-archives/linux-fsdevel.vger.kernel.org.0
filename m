Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEBD16F4DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 02:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbgBZBNl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 20:13:41 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43544 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730137AbgBZBNk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:13:40 -0500
Received: by mail-io1-f67.google.com with SMTP id n21so1430732ioo.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2020 17:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Md+dR3QAjkgbDHCOD0u7elrQ4FkH1YpiL26CdEGfHpk=;
        b=R+I4pjf2mqXjj+8BCUTibnuDnoALhtisnlvmkpZOTuALmHc7sxQkJkSmlDj9G1kp4F
         5BN4PN1Mkph70DyXdrt6H34L57uHBEbuqveIFJOEdumqQGaX7t7ictKgocS237fQvqEo
         mS1i1JZbRPKsrVo/wv152qvDzlvEDv5Elwub8wVfQX/18NUFIDXkNounJ4Bkwum/W3XS
         bs2l15mYhvWlgK6GvQGKHdJtRx1GIM7bCfqL4z+J8xDLpUr1ejtu/o+fVT5+VcHx4z2c
         /+hr2qxBNVjW3inC/MKwqcMmwv6Tgce3DMfVvk6I/17eliRdypZ+IPVA4fIYctm4/bBO
         +dbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Md+dR3QAjkgbDHCOD0u7elrQ4FkH1YpiL26CdEGfHpk=;
        b=RZlDpa6uIcuIvD13wfM/023mW3w5KoumLskNvK0AKmoMUJGoyv42fhpd02a0NCvkgM
         3VyUrU8WGdda3GCJVBcDUrjd3LKcaY6nx6r0xRoP/Zzc7cXS8bvWMttZnvFLxj8JcWvu
         CWEhRFrHNo/dtamgYIKZrVdXz9uY6wM7bs71KkbDXCsHWBPNkdtMhVcXXKDpBlOiDklz
         2zqLtcatGyTi/WPQ00JsUdOrz3b4R94hlc59VKFgejiFPfPeKj2Ecc08cQUmB1JySWQ5
         aM7RAfYDBj3wYL3fnbv/igVCh8j6/KW1gvGLxjwUPuTUA2MwiSh5k/6NBnwnFTZc8946
         MVpg==
X-Gm-Message-State: APjAAAUUg/SOCNSsoMNaHjSD92z1E6n/Tg+o03zib5DDri5nmWLRBumQ
        wBHWkjIKuIw1cOitx13ugAN+1Q==
X-Google-Smtp-Source: APXvYqyziRLA63DqgeyRhiV9j8Pxm2Iva9SkiX6jHMkmIhWdxef0d17W2ImORx3FKCTw289xP0FCYw==
X-Received: by 2002:a05:6638:1a8:: with SMTP id b8mr1405336jaq.34.1582679618849;
        Tue, 25 Feb 2020 17:13:38 -0800 (PST)
Received: from google.com ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id q1sm108128ile.71.2020.02.25.17.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 17:13:38 -0800 (PST)
Date:   Tue, 25 Feb 2020 18:13:35 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mattias Nissler <mnissler@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Raul Rangel <rrangel@google.com>,
        linux-fsdevel@vger.kernel.org,
        Benjamin Gordon <bmgordon@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] Add a "nosymfollow" mount option.
Message-ID: <20200226011335.GA12632@google.com>
References: <20200226010706.9431-1-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226010706.9431-1-zwisler@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 25, 2020 at 06:07:06PM -0700, Ross Zwisler wrote:
<>
> Changes since v5 [1]:

And of course this version is v6.  Sorry for the omission.
