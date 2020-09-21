Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B004273198
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 20:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgIUSL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 14:11:27 -0400
Received: from verein.lst.de ([213.95.11.211]:41420 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbgIUSL1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 14:11:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6C49D68AFE; Mon, 21 Sep 2020 20:11:23 +0200 (CEST)
Date:   Mon, 21 Sep 2020 20:11:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/5] fs,nfs: lift compat nfs4 mount data handling into
 the nfs code
Message-ID: <20200921181123.GA1776@lst.de>
References: <20200917082236.2518236-1-hch@lst.de> <20200917082236.2518236-3-hch@lst.de> <20200917171604.GW3421308@ZenIV.linux.org.uk> <20200917171826.GA8198@lst.de> <20200921064813.GB18559@lst.de> <CAFX2Jfks7QTS5crWa43mp4TQ3LoquvRxjuEeCpsZr1aees00eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFX2Jfks7QTS5crWa43mp4TQ3LoquvRxjuEeCpsZr1aees00eA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 21, 2020 at 12:05:52PM -0400, Anna Schumaker wrote:
> This is for the binary mount stuff? That was already legacy code when
> I first started, and mount uses text options now. My preference is for
> keeping it as close to the original code as possible.

Ok.  Al, are you fine with the series as-is then?

> 
> I'm curious if you've been able to test this? I'm not sure if there is
> a way to force binary mount data through mount.nfs

The test is pretty trivial - even the most recent nfsutils supports the
binary mount data.  You just need to patch out the detection for a
modern kernel.
