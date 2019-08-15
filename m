Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00AC08F2DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 20:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbfHOSKN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 14:10:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44804 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbfHOSKM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:10:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so1616416pgl.11;
        Thu, 15 Aug 2019 11:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YGZciRmFKywos7phtHka3BMLOjJ5GD0teHhlJqhmVkk=;
        b=refM5sSMD7XaWN2cBYtXuBqQL++UFaQwWAlfDTzJPByqFlruWjmG6Yh089jW7TdpbD
         NrxNm0s2FZstcIYgXU/1OVsLWK+FGl/oYQP7+rTaMZkVBgGR23anbQo8oXgra9wTo9FE
         j2SPBqMOEPNcKZuxqfPe/Pg1VNQm0EO34QutZQTrQlKL2cYjCOVrLe8Oxo+zJZteOQlu
         B8hMLNBQEAo1UHIr3ABYn9iPuYxpRN+b0Z+J5xpbw/J0aCqSamjWusXlwPIWC+3YINI7
         nT835bJJdCLvSjcjCqTDzc+ntlidStA5Dl6+CgzdON8g1MYQ6qhhFDs0HvmQv88M+BJb
         dCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YGZciRmFKywos7phtHka3BMLOjJ5GD0teHhlJqhmVkk=;
        b=TAK2zbsMzphSzYHz0H+jiKefk9nQKLojQnv4w2oyYEe9IVnsv354JFR9RuqHQ0oMi4
         VQTQa57wU3hGBoM/IEoFWeBxu4mAr8acyuAqgMG/NBMEEw2c3zDpBm020QPkxixO0aVH
         mLP5/NMFXxSsEMBzEJVX2zGlrizflC6RWasibeQJHy2UrJ+GoGd+TwZn0XC7QaSkYowt
         hydSrYVAui5rOYlArGaUrnv+3gENtC5Etf3+v2aQWrWPmUXLZg4rFYLKnCnkka/vhW8+
         JY/kY3kxJPN/dQ5UIcMKejxj60WjTpazOn8A/n49jEPjZy7aRzF9ysJpT+Em3lrLOlvA
         NR6w==
X-Gm-Message-State: APjAAAV6j9qQDjQtnH/jr9u1i4Nfj209bB1zZ38L3bQDW6zGIsDifbnJ
        EqZeVTw88JRFV32515soid0=
X-Google-Smtp-Source: APXvYqxIDdyy6by/HwcLogs24nzI99cv+AM8Nkc5yJYlPuae0cwXsF1pvVTorAHFvjBOwQbrOwQiZw==
X-Received: by 2002:a62:38d7:: with SMTP id f206mr6797850pfa.102.1565892612133;
        Thu, 15 Aug 2019 11:10:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n98sm1927437pjc.26.2019.08.15.11.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 11:10:11 -0700 (PDT)
Date:   Thu, 15 Aug 2019 11:10:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Anatolij Gustschin <agust@denx.de>,
        Jean Delvare <jdelvare@suse.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        openipmi-developer@lists.sourceforge.net,
        linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 06/18] compat_ioctl: move WDIOC handling into wdt
 drivers
Message-ID: <20190815181010.GA28580@roeck-us.net>
References: <20190814204259.120942-1-arnd@arndb.de>
 <20190814205245.121691-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814205245.121691-1-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 14, 2019 at 10:49:18PM +0200, Arnd Bergmann wrote:
> All watchdog drivers implement the same set of ioctl commands, and
> fortunately all of them are compatible between 32-bit and 64-bit
> architectures.
> 
> Modern drivers always go through drivers/watchdog/wdt.c as an abstraction
> layer, but older ones implement their own file_operations on a character
> device for this.
> 
> Move the handling from fs/compat_ioctl.c into the individual drivers.
> 
> Note that most of the legacy drivers will never be used on 64-bit
> hardware, because they are for an old 32-bit SoC implementation, but
> doing them all at once is safer than trying to guess which ones do
> or do not need the compat_ioctl handling.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

This patch doesn't seem to have a useful base (or at least git says so).
It does not apply to mainline nor to my own watchdog-next branch.
I assume you plan to apply the entire series together. Please not
that there will be conflicts against watchdog-next when you do so.

Guenter
