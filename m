Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 514498EEAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 16:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbfHOOvI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 10:51:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48262 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731269AbfHOOvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:51:08 -0400
Received: from mail-ot1-f72.google.com ([209.85.210.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1hyH5U-0008TI-CA
        for linux-fsdevel@vger.kernel.org; Thu, 15 Aug 2019 14:50:48 +0000
Received: by mail-ot1-f72.google.com with SMTP id p7so2359171otk.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2019 07:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yNivIfUkkplVV5pp6FTdEbZdfJdI5yapbUq276+kheo=;
        b=tm+6208wGM9MIaanoaXtPa6jjrw9ofZVKFbDgGTlUffhEOU1sAp2ya65JBiN5z5Vs3
         rKTE2wPek9i/f8CJdRmFsYSiWZy3W8tGbsPvVe5OFMXnAUO3ZXnt+I3eLTJLMTXbEqQj
         6J2P/Kha6wQkR7OgrX5/wR19i2Mo01pc8dtPBUZjSOJzkY4HRAzrdNQ6Meq9hXEiokKU
         9GTv5C7UrpFc/6PXk8n4If5jhBs44Mh67ChMak+/sEpIc3QMr545X53KRg0InJ4r7X9Z
         rPoljsY+O61NmJeCIIyRQrERkbMl1FyVr30ixQ1q8B62XvdiaCdA86JjO1bhUZK32dR8
         WCgA==
X-Gm-Message-State: APjAAAWwMesmfehqAkDYGvlylQtESDaERbhCcon3LDHeJGEJpd7n8rm1
        tCECkmLRRQcra/mfxj+CctPZmx+oqE4w/T5uxp77sCq7D6/nVWcRt83orsR+Sdf/itlb+XS1ToP
        mQIbn1716gEHU1zpCuGdMuRiV8hXLk8nY5vuw1GoMLh4=
X-Received: by 2002:a6b:8b47:: with SMTP id n68mr5665459iod.191.1565880646904;
        Thu, 15 Aug 2019 07:50:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwcSUVoo5IYuezAtpbdOKSul/TTMZm3PFMuJPW0LxqdLEZKI7wZF2mkZZgZLypI7dFN39oqFA==
X-Received: by 2002:a6b:8b47:: with SMTP id n68mr5665427iod.191.1565880646626;
        Thu, 15 Aug 2019 07:50:46 -0700 (PDT)
Received: from localhost ([2605:a601:ac3:9720:443b:aa6:53cb:2ee7])
        by smtp.gmail.com with ESMTPSA id r5sm2054854iom.42.2019.08.15.07.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 07:50:46 -0700 (PDT)
Date:   Thu, 15 Aug 2019 09:50:45 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Stefan Bader <stefan.bader@canonical.com>,
        Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Brad Figg <brad.figg@canonical.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH 0/1] Small potential fix for shiftfs
Message-ID: <20190815145045.GY10402@ubuntu-xps13>
References: <20190815143603.17127-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815143603.17127-1-oleksandr@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 04:36:02PM +0200, Oleksandr Natalenko wrote:
> Hey, people.
> 
> I was lurking at shiftfs just out of curiosity and managed to bump into
> a compiler warning that is (as I suppose) easily fixed by the subsequent
> patch.
> 
> Feel free to drag this into your Ubuntu tree if needed. I haven't played
> with it yet, just compiling (because I'm looking for something that is
> bindfs but in-kernel) :).

Thanks for the patch. Christian has actually already sent a patch for
this along with another patch which is still under review:

https://lists.ubuntu.com/archives/kernel-team/2019-July/102449.html

Also note that currently shiftfs is only in Ubuntu distro kernels, and
Ubuntu-specific kernel patches should be directed at
kernel-team@lists.ubuntu.com rather than lkml. If you'll be at LPC,
there's a session to discuss the future of upstreaming shiftfs that you
might find interesting.

Thanks!
Seth
