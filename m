Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB784149BA0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2020 16:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgAZPre (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jan 2020 10:47:34 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45690 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgAZPrd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jan 2020 10:47:33 -0500
Received: by mail-yb1-f196.google.com with SMTP id x191so3689882ybg.12;
        Sun, 26 Jan 2020 07:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2xbk8AdWIZmse3B+nB63l0NWf7gcst2GZzaX7cH6+Rk=;
        b=Sny0GkweHawfCGschvMy3kTofssyVxPCS0Xe31agFEXH2DnfkqrnpH9Qyfc0gNUm2S
         7/AxdrHFGQwY2H2dwiP6rvG6tCa7XACRTKzmPzFznJhJj08lAQpMtHczqCjOGVCU3x+i
         zKP8nUcKQMAGb+UYmJb/7ryPB9Mw/U2oiz1UKb0fPoF4mF5BudiQ2dEx90xLxw5otSAp
         9fmRu8WNfNuljNOayIvT5boniU6zQErTGsj2ZcYbdPf9aYoDfo7PhcvB8UrjlDlca8ve
         jVuxbKvrGw1ydhKIIlA+chqZ+AFVeyamBxcdcAyYqTIT47/2VyegmFJdmAFCjlMdBUt1
         zm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=2xbk8AdWIZmse3B+nB63l0NWf7gcst2GZzaX7cH6+Rk=;
        b=sE1iBQhXJKqk3dnxjrV84NaUng/MThGt9t4HXisR7umWdEscNHW3Sg/wEZ0zaf7OvN
         oJ8oyJhABgxVxqkMNOsr1Ccfr5NMiCPVfiwQZa/tOm1nH2z0OJvqoIUQz4h6l5S6HWO4
         P8y5GyZ6Eni1VpMdG2xJtoL5L7DkgTMXLQL95dTz7N1Ly6mAwbu85aT2M5ENkvzrFU5u
         SBFlnZlX4U1aKEhqW8Zx+IT+sutIXZQxlM8Qb0BNH+hXha4ygBYjxcSOfnAPOVtOQnvi
         M91hy0QxtPf9zbiyYlzjEDtljPThXRgQ8vpmoaRIf1QSrK+0afZtOfXmb90dVaDyrFye
         ZU1Q==
X-Gm-Message-State: APjAAAW5L59UXXt3D77Rzc/IUjwT4Y7uevQMB8UGCTGWmIJxIdcE/y4j
        WiNsddUUqxQM4MK/QIM/ldw=
X-Google-Smtp-Source: APXvYqxvf/6JwAOXZhkX95ONMDryWNE+o/mE5fN9F9087lRqh1nXGJlr9CV8HaTXjy7HRjgfZPOGKQ==
X-Received: by 2002:a25:ef51:: with SMTP id w17mr10381069ybm.477.1580053652415;
        Sun, 26 Jan 2020 07:47:32 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d188sm1747466ywe.50.2020.01.26.07.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jan 2020 07:47:31 -0800 (PST)
Date:   Sun, 26 Jan 2020 07:47:30 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        raven@themaw.net, Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/14] Add sample notification program [ver #3]
Message-ID: <20200126154730.GA18893@roeck-us.net>
References: <157909503552.20155.3030058841911628518.stgit@warthog.procyon.org.uk>
 <157909509882.20155.1159021562184142124.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <157909509882.20155.1159021562184142124.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 01:31:38PM +0000, David Howells wrote:
> The sample program is run like:
> 
> 	./samples/watch_queue/watch_test
> 
> and watches "/" for mount changes and the current session keyring for key
> changes:
> 
> 	# keyctl add user a a @s
> 	1035096409
> 	# keyctl unlink 1035096409 @s
> 
> producing:
> 
> 	# ./watch_test
> 	read() = 16
> 	NOTIFY[000]: ty=000001 sy=02 i=00000110
> 	KEY 2ffc2e5d change=2[linked] aux=1035096409
> 	read() = 16
> 	NOTIFY[000]: ty=000001 sy=02 i=00000110
> 	KEY 2ffc2e5d change=3[unlinked] aux=1035096409
> 
> Other events may be produced, such as with a failing disk:
> 
> 	read() = 22
> 	NOTIFY[000]: ty=000003 sy=02 i=00000416
> 	USB 3-7.7 dev-reset e=0 r=0
> 	read() = 24
> 	NOTIFY[000]: ty=000002 sy=06 i=00000418
> 	BLOCK 00800050 e=6[critical medium] s=64000ef8
> 
> This corresponds to:
> 
> 	blk_update_request: critical medium error, dev sdf, sector 1677725432 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> 
> in dmesg.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

mips:allmodconfig:

samples/watch_queue/watch_test.c: In function ‘keyctl_watch_key’:
samples/watch_queue/watch_test.c:34:17: error: ‘__NR_keyctl’ undeclared

Guenter
