Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FAE364645
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 16:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240295AbhDSOhq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 10:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240144AbhDSOho (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:37:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4957761002;
        Mon, 19 Apr 2021 14:37:12 +0000 (UTC)
Date:   Mon, 19 Apr 2021 16:37:08 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Tyler Hicks <code@tyhicks.com>,
        Christian Brauner <brauner@kernel.org>,
        ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 1/3] ecryptfs: remove unused helpers
Message-ID: <20210419143708.7zlmjeabuzfyf2rs@wittgenstein>
References: <20210409162422.1326565-1-brauner@kernel.org>
 <20210409162422.1326565-2-brauner@kernel.org>
 <20210419044850.GF398325@elm>
 <YH2KVPsPdSFMEhEY@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YH2KVPsPdSFMEhEY@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 19, 2021 at 01:49:08PM +0000, Al Viro wrote:
> On Sun, Apr 18, 2021 at 11:48:50PM -0500, Tyler Hicks wrote:
> > On 2021-04-09 18:24:20, Christian Brauner wrote:
> > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > 
> > > Remove two helpers that are unused.
> > > 
> > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > Cc: Tyler Hicks <code@tyhicks.com>
> > > Cc: ecryptfs@vger.kernel.org
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > 
> > I'll pick this patch up now as it looks like it didn't make it into your
> > v2 of the port to private mounts. I'll review those patches separately.
> 
> FWIW, there's also a series in vfs.git #work.ecryptfs (posted Mar 20),
> and that, AFAICS, duplicates 483bc7e82ccfc in there...

Yeah, this is why I dropped the patch in the combined series I sent out
last week.
