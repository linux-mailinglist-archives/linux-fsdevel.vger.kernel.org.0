Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04EAD162AD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 17:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBRQke (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 11:40:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32984 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgBRQke (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:40:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id u6so24828419wrt.0;
        Tue, 18 Feb 2020 08:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Qrn/311N8UKWCU3JBItnZPXVbDym7dBk+dJkq1lmoEQ=;
        b=Spm+JfJajdxPAfH0FP+lNEzVOzmRBFnCutuIbmm2nw9nzUxdFWhYqDOlsJ2NSvCnQ0
         5xK1qTa89q0rXa8bOm5n5jpibys2+uzIQ0hcININxPDZsCs03aj62CQInGfpQAc4C60V
         1dlj+4TEWQC9h+s82rwJk2DzRq3qO6YFCH02SzxFDmnGRHuSVu53Q8K5F6JyDmBnw0wZ
         mYzt/Apjh7D8vdMd7HJDr9AmUgZzEuJmtH515dWYbKl+hY0GEBFg3yJoOhzncak8TAH+
         1c/xeFUchE5CT628YfEFPSB7USU03Lfu4vPSVNV4sOnmE43AHVNJfBzV0isOTamJGn5s
         5S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Qrn/311N8UKWCU3JBItnZPXVbDym7dBk+dJkq1lmoEQ=;
        b=Ba22vdK6ZcSIov2Pi7cs9IkPZdUZwHyqX52GiX8lyiYEAu0gqPDFhx8rEUwOZwsUgJ
         vM9Pbuy16VG29L0LZ7X+c6T3m9WdBe+SC7/b2vs458T5hyfQIpNScbSKSOK2XJ1HNQ2p
         2tckl5Ouw/U6lQghXwJdK/IYKrDKJZbR7a8LVfR0tIMB1AJkK7VefHaAE22ZO4lA4j6x
         iDDteO7RqfLwuFpU1Aa6WFXEKVXvz8hLMDQSSrD69Szw5yuIRauLHWP3Bt9Z07LLHAtl
         uXIpAh5yRpe30Ly8a7eq16sg6gxfY80uPE6THZUY++HVgtXZfCaCf3/k4PfnOe1SiQ9I
         e5KA==
X-Gm-Message-State: APjAAAVvhylxPwG/U6WgVHZ8y9VqGP7/xWALyEvMGU+rghOC9Kw2Rptj
        h9WMUvXYBw1U9krViC0SNog=
X-Google-Smtp-Source: APXvYqynwmR/FUKse+HbFGtRSlF5Ycib8DCRIUWZ9ge+rXwKutwFUdlpFoxp6pz5XqGoOjfeaQlMiQ==
X-Received: by 2002:a05:6000:1208:: with SMTP id e8mr31277467wrx.351.1582044033050;
        Tue, 18 Feb 2020 08:40:33 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id r6sm6763636wrp.95.2020.02.18.08.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 08:40:32 -0800 (PST)
Date:   Tue, 18 Feb 2020 17:40:31 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Namjae Jeon <linkinjeon@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        valdis.kletnieks@vt.edu, sj1557.seo@samsung.com, arnd@arndb.de,
        namjae.jeon@samsung.com
Subject: Re: [PATCH v13 00/13] add the latest exfat driver
Message-ID: <20200218164031.daoaxqasdtatmaqo@pali>
References: <20200121125727.24260-1-linkinjeon@gmail.com>
 <20200125213228.GA5518@lst.de>
 <20200127090409.vvv7sd2uohmliwk5@pali>
 <20200127092343.GB392535@kroah.com>
 <20200127092840.gogcrq3pozgfayiy@pali>
 <20200127093328.GA413113@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200127093328.GA413113@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday 27 January 2020 10:33:28 Greg KH wrote:
> On Mon, Jan 27, 2020 at 10:28:40AM +0100, Pali Rohár wrote:
> > On Monday 27 January 2020 10:23:43 Greg KH wrote:
> > > On Mon, Jan 27, 2020 at 10:04:09AM +0100, Pali Rohár wrote:
> > > > On Saturday 25 January 2020 22:32:28 Christoph Hellwig wrote:
> > > > > The RCU changes looks sensible to me:
> > > > > 
> > > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > 
> > > > Great! Are there any other issues with this last version?
> > > > 
> > > > If not, Greg would you take this patch series?
> > > 
> > > Me?  I'm not the vfs/fs maintainer.
> > 
> > You took exfat driver (into staging), so I thought that exfat handled by you.
> 
> I am the maintainer of drivers/staging/*.
> 
> scripts/get_maintainer.pl is your friend :)

Al Viro, you are already in loop, would you take exfat fs in current
form? Or are there any other issues which needs to be fixed?

-- 
Pali Rohár
pali.rohar@gmail.com
