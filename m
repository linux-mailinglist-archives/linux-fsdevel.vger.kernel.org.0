Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1D43513D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 12:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhDAKmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 06:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234122AbhDAKmS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:42:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7912060FEA;
        Thu,  1 Apr 2021 10:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617273738;
        bh=ivyxGcntTg0MLgIUbYonsE4bzKVNII7gy4+mFXP/MX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wmRhrYsSkLwWL9wFaT/ay5EtNMKr+BEmGf7tHJNk365Vqlx6j36bGvQfLaW8w4tTB
         nwn+51a4HcfgVmAm72PRj1duigwVYKixKJn9xq+Q5xYMt8XM2pGvCS7plI7uPxg+HQ
         n+dpWM/sdeb3KHNR6SWTrUONBqLNnQJQxtv/pfPE=
Date:   Thu, 1 Apr 2021 12:42:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com,
        Kees Cook <keescook@chromium.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Jason Wang <jasowang@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christoph Hellwig <hch@infradead.org>,
        Hridya Valsaraju <hridya@google.com>, arve@android.com,
        viro@zeniv.linux.org.uk, joel@joelfernandes.org,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        maco@android.com
Subject: Re: Re: [PATCH 2/2] binder: Use receive_fd() to receive file from
 another process
Message-ID: <YGWjh7qCJ8HJpFxv@kroah.com>
References: <20210401090932.121-1-xieyongji@bytedance.com>
 <20210401090932.121-3-xieyongji@bytedance.com>
 <YGWYZYbBzglUCxB2@kroah.com>
 <CACycT3ux9NVu_L=Vse7v-xbwE-K0-HT-e-Ei=yHOQmF66nGjeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3ux9NVu_L=Vse7v-xbwE-K0-HT-e-Ei=yHOQmF66nGjeQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 06:12:51PM +0800, Yongji Xie wrote:
> On Thu, Apr 1, 2021 at 5:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Apr 01, 2021 at 05:09:32PM +0800, Xie Yongji wrote:
> > > Use receive_fd() to receive file from another process instead of
> > > combination of get_unused_fd_flags() and fd_install(). This simplifies
> > > the logic and also makes sure we don't miss any security stuff.
> >
> > But no logic is simplified here, and nothing is "missed", so I do not
> > understand this change at all.
> >
> 
> I noticed that we have security_binder_transfer_file() when we
> transfer some fds. I'm not sure whether we need something like
> security_file_receive() here?

Why would you?  And where is "here"?

still confused,

greg k-h
