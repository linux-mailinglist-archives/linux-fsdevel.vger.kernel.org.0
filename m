Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA1BE8F2CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 20:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbfHOSGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 14:06:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44831 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729560AbfHOSGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:06:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id c81so1688636pfc.11;
        Thu, 15 Aug 2019 11:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2kefMAz7f9gRkj6gIipqp7OElUm+jYSHKa3bI/ilJxk=;
        b=mAu+xdgGUET1GDkag0jB49aHKfefXJRwDSZpt6Lkd1QSl6+2RqT5ZzGcXlbE+EZa60
         wPRSEmb4o6yJq5mDH6JZZrigRQOTzQrglTQF6mTVD53IHa46R29ODc2ESVmDH7IyteEX
         /QmNvQ898KmZVzxbgVcv5DvPafILMAVX3deLdXpsnX9vRQa97VNvVx9A0IBjaiylJLPC
         pm2/KxT1ouXOazl3Q1H5Fzef5T8Yc8L6kaX2OJR7haDCQlQkv3aA3gsbS/68yEAqveBv
         ujQqUz+UvyhRx5i6F3RlERJPtvpTv5E5sIrdAlEOmbOZaCWOquWZ5+p9yOown3CI6DRh
         I+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2kefMAz7f9gRkj6gIipqp7OElUm+jYSHKa3bI/ilJxk=;
        b=oGG/xN7SBPZgM4UWc6jXoBADIb7UYLZG1rOLm5w5nsGUEQPLRHm5N3vWYAMvmI/e9+
         xVqlktH+gwknFs7q/1fysHto71guXIckaIzwtV2ToALSWG1VN1Q4G8nQVcq92PU+d+Cg
         1eZbvHVYngV3Bun6VVXDFlJNtZ9UH/9stf1lcg5UvqP1TTqGo2VuzBdsiIDU4OV5pBOC
         1tGY5Nc1bJx3NtYIYZhCV08I5TZo6xxmEtSNj9gi92OO64UhSz84FAj+izFYZHxEm9/5
         ASmlwzjwXhCMGrOR3djvPRB3Z+tJWMmXdxiUnAZaQXoc70itXtRLEfP484glc3cK12y/
         KFBA==
X-Gm-Message-State: APjAAAWqYIyaBaBHePeZ/tTgKlzp0XpNog4DfL746ZuI/sAQrfoewkv9
        lQ95grRmqgNHaoCXpzKcWxU=
X-Google-Smtp-Source: APXvYqybP544W3Kc2fBQ0i2QzokjkYIZP2EDR9lfm2C/+9XxwPS8YhhjAgZCVolC0Q1H6kTJQfc5Ow==
X-Received: by 2002:aa7:8a92:: with SMTP id a18mr6804034pfc.216.1565892399936;
        Thu, 15 Aug 2019 11:06:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o11sm3855461pfh.114.2019.08.15.11.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 11:06:38 -0700 (PDT)
Date:   Thu, 15 Aug 2019 11:06:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v5 05/18] watchdog: cpwd: use generic compat_ptr_ioctl
Message-ID: <20190815180637.GA20006@roeck-us.net>
References: <20190814204259.120942-1-arnd@arndb.de>
 <20190814204259.120942-6-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814204259.120942-6-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 14, 2019 at 10:42:32PM +0200, Arnd Bergmann wrote:
> The cpwd_compat_ioctl() contains a bogus mutex that dates
> back to a leftover BKL instance.
> 
> Simplify the implementation by using the new compat_ptr_ioctl()
> helper function that will do the right thing for all calls
> here.
> 
> Note that WIOCSTART/WIOCSTOP don't take any arguments, so
> the compat_ptr() conversion is not needed here, but it also
> doesn't hurt.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
