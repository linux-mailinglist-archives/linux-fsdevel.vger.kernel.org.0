Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAC814AD80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 02:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgA1B1t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 20:27:49 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:46813 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgA1B1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:27:49 -0500
Received: by mail-pl1-f171.google.com with SMTP id y8so4424599pll.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2020 17:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Oeuv8OC2ETQy2SZkzvJfDSUrwSo+1NUc8cKI9iTONQ8=;
        b=tsNrz/+DVErIanVvLjLCJDpvchi7+7dXwUgFy6LTLS/g63Iuy0czegzgArHtUHTw2R
         cO0bLQNH6T+voSNkM05RGI7JcoA/+MX+39CQOoPMFFalKon8gswrnZZbxBrohhcqAubI
         Bddzw0oaBFzOoG+RuvgDnlrzrB3pbV073pTNiucsb/6lL04g/oZI12CZGYeZFbreLNcN
         y9BC0gCsTg9Fsq5rLtJlILA10UPNR49Xnk0aqy8iAXlkt5q0FS5Fqn4mQHjWadd/W004
         4KBRBvE4CmDhsaAblWf7RJZTvfbL/HhAiZptNjWOmaZj3MZBjOIC3kiQfEkl2Me529rh
         j+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oeuv8OC2ETQy2SZkzvJfDSUrwSo+1NUc8cKI9iTONQ8=;
        b=XhUzuNu78hJOscVgcKhr5cL0l0OHBKpRSyO5/IoUChc0hG3vbLddSYptHefLqaglrm
         qDdfcM8qn/PTgGhVyY8IIle1kVcQfTgxoheASdqe/I1ZrIiAlE6gzlwovs6FAN+Gmzmp
         7Gg6O4EsptqrGohCL9kntIW4ba+N5INn8zqBpr2fI2UXplXDvqMlbZv+ZJP2gVNuUoId
         AsCdP6enjENntpIH/5BbkjWt9bs8WmvIY2Ezn09Y53wfkdhQTxDQjd+WrIk1Nq2f19Qf
         P1E7f0Uth1vZSrC+2FtnNe+vy11dulE61/LHTCMCrzcCO1xT7A8Sr0Zu3jDUts9XX360
         Cy2w==
X-Gm-Message-State: APjAAAU/KtcipjH7/aVPTmGB2bZSO4uqLwazcdkgTNYicz5ts8pa7xOI
        ej4FCAVyJJFSZAMsF+9yzVrQpg==
X-Google-Smtp-Source: APXvYqyIrVSjFX6CMWAk58ZCE5+ND/bKldZg1lH8J2PCKdwissD0xcnadxLJUcH0eWNEheLMHaiLbQ==
X-Received: by 2002:a17:90a:2004:: with SMTP id n4mr1806117pjc.20.1580174868472;
        Mon, 27 Jan 2020 17:27:48 -0800 (PST)
Received: from vader ([2620:10d:c090:200::3:4a69])
        by smtp.gmail.com with ESMTPSA id 11sm17804802pfz.25.2020.01.27.17.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 17:27:47 -0800 (PST)
Date:   Mon, 27 Jan 2020 17:27:47 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Message-ID: <20200128012747.GB683123@vader>
References: <20200117222212.GP8904@ZenIV.linux.org.uk>
 <20200117235444.GC295250@vader>
 <20200118004738.GQ8904@ZenIV.linux.org.uk>
 <20200118011734.GD295250@vader>
 <20200118022032.GR8904@ZenIV.linux.org.uk>
 <20200121230521.GA394361@vader>
 <CAOQ4uxgsoGMsNxhmtzZPqb+NshpJ3_P8vDiKpJFO5ZK25jZr0w@mail.gmail.com>
 <20200122221003.GB394361@vader>
 <20200123034745.GI23230@ZenIV.linux.org.uk>
 <20200123071639.GA7216@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123071639.GA7216@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 06:16:39PM +1100, Dave Chinner wrote:
> On Thu, Jan 23, 2020 at 03:47:45AM +0000, Al Viro wrote:
> > On Wed, Jan 22, 2020 at 02:10:03PM -0800, Omar Sandoval wrote:
> > 
> > > > Sorry for not reading all the thread again, some API questions:
> > > > - We intend to allow AT_REPLACE only with O_TMPFILE src. Right?
> > > 
> > > I wasn't planning on having that restriction. It's not too much effort
> > > for filesystems to support it for normal files, so I wouldn't want to
> > > place an artificial restriction on a useful primitive.
> > 
> > I'm not sure; that's how we ended up with the unspeakable APIs like
> > rename(2), after all...
> 
> Yet it is just rename(2) with the serial numbers filed off -
> complete with all the same data vs metadata ordering problems that
> rename(2) comes along with. i.e. it needs fsync to guarantee data
> integrity of the source file before the linkat() call is made.
> 
> If we can forsee that users are going to complain that
> linkat(AT_REPLACE) using O_TMPFILE files is not atomic because it
> leaves zero length files behind after a crash just like rename()
> does, then we haven't really improved anything at all...
> 
> And, really, I don't think anyone wants another API that requires
> multiple fsync calls to use correctly for crash-safe file
> replacement, let alone try to teach people who still cant rename a
> file safely how to use it....

AT_REPLACE would have a leg up in that we can at least mention the (lack
of) integrity guarantees in the man page. It's no suprise that no one
gets rename right when the documentation make no mention of
integrity/durability/crash safety.

Sure, if everyone wants AT_REPLACE to guarantee integrity, we can do
that. But I'm going to start with the simplest proposal that makes no
such guarantees.
