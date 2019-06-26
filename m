Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65AF956638
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 12:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfFZKGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 06:06:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55205 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfFZKGN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:06:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so1442785wme.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2019 03:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lA6WHOHvwnqcXTXfllIH/9q+Q3SBJoDs9qjbJsWJXYo=;
        b=JxHjA63RdBaeJkw3kbpH30q43ofn69cZUNRv4WbfUfGPNuzqfzd0T/hFMTA9tsXwLN
         bbRY1TP83zgESaLDObC8hOeSLczI8ydawaziKj6FoSkjyBO074/dPnxLYw6A7kQ2bcyj
         bcEVMuaDcqxfXn0c/sJZneTf14QP2QFJoKohRFBqi3GvHYGwceqGWF6jnm+eb70Ps8xU
         Ha4WuoCAJ+oqxTrCqMLEo02JqHhl0Ede6YOMDUER13NIoynVi2EwRbxKA5OtQkUBw0Le
         x74neMxRBGwFKgoEahX+AHm2XA6MWNwWb4OS1UWXn8y4OOH0sVXLxIP4Fss8dD4EwY45
         krpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lA6WHOHvwnqcXTXfllIH/9q+Q3SBJoDs9qjbJsWJXYo=;
        b=C8BnpSiKhydlM4mkerIQWLDc4sNiym0hmt7USXASa5hr11LqA7abMFv/k89M6sQolT
         wo9Hr+PUExLgpR0HyR+A12Rrnd0YXfqzjW1EqphNqT+idEhNYsC6o56QqnONE7tXdQLk
         DqkLJivQPekMIUuKA3UTmA9WQBOcE9ZUk6GWx8uN4x7RzATeG7uXt5RnppDI+PsmMEk6
         G5jjrOvK8IcHmu4DIQ7u5lSQtcUUhdXpzUR+tYeRgo5cSB8p4dGUutxcgzKLHt9Gtbnn
         ENKqjXwAZvzJ59gmxRupZqZ54RurKLNjCfUt4apNn55aumwtHo3kKb9hJt8KnqBfkcT2
         Zmrg==
X-Gm-Message-State: APjAAAVTcJr0zNfgPQuJrv5aaRH+LE5J1+49MbD0nRnH7of8Sz4fQG1J
        vKxgWoScNLj29n0Rn921U0IDPoZYC/uGlQ==
X-Google-Smtp-Source: APXvYqy4bJw6Ja0OTHeae0vvDLW3q24LGQfnwFPQEYguji1pxLGtcAkMMXquKp42kHJL0Xtua8J1Fg==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr2195048wmg.48.1561543571691;
        Wed, 26 Jun 2019 03:06:11 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id f197sm2333661wme.39.2019.06.26.03.06.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 03:06:11 -0700 (PDT)
Date:   Wed, 26 Jun 2019 12:06:10 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/25] vfs: Allow fsinfo() to query what's in an
 fs_context [ver #14]
Message-ID: <20190626100609.jerxqozukygyojik@brauner.io>
References: <20190625092728.z3jn3gbyopzcg2it@brauner.io>
 <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
 <156138535407.25627.15015993364565647650.stgit@warthog.procyon.org.uk>
 <6575.1561543379@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6575.1561543379@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 26, 2019 at 11:02:59AM +0100, David Howells wrote:
> Christian Brauner <christian@brauner.io> wrote:
> 
> > > +	ret = mutex_lock_interruptible(&fc->uapi_mutex);
> > > +	if (ret == 0) {
> > > +		ret = -EIO;
> > 
> > Why EIO when there's no root dentry?
> 
> Because I don't want to use ENODATA/EBADF and preferably not EINVAL and
> because the context you're accessing isn't in the correct state for you to be
> able to do that.  How about EBADFD ("File descriptor in bad state")?

Do we have that? If so that sounds good.

Christian
