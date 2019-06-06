Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABFC437DDE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 22:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfFFUMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 16:12:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:58646 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727082AbfFFUMA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 16:12:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B49AAF8A;
        Thu,  6 Jun 2019 20:11:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 Jun 2019 22:11:57 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Renzo Davoli <renzo@cs.unibo.it>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Davide Libenzi <davidel@xmailserver.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/1] eventfd new tag EFD_VPOLL: generate epoll events
In-Reply-To: <20190603150010.GE4312@cs.unibo.it>
References: <20190526142521.GA21842@cs.unibo.it>
 <20190527073332.GA13782@kroah.com> <20190527133621.GC26073@cs.unibo.it>
 <480f1bda66b67f740f5da89189bbfca3@suse.de>
 <20190531104502.GE3661@cs.unibo.it>
 <cd20672aaf13f939b4f798d0839d2438@suse.de>
 <20190603150010.GE4312@cs.unibo.it>
Message-ID: <5d44edf655e193789823094d1b4301fd@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Renzo,

On 2019-06-03 17:00, Renzo Davoli wrote:
> Hi Roman,
> 
> 	 I sorry for the delay in my answer, but I needed to set up a minimal
> tutorial to show what I am working on and why I need a feature like the
> one I am proposing.
> 
> Please, have a look of the README.md page here:
> https://github.com/virtualsquare/vuos
> (everything can be downloaded and tested)

Is that similar to what user-mode linux does?  I mean the principle.

> I am not trying to port some tools to use user-space implemented
> stacks or device
> drivers/emulators, I am seeking to a general purpose approach.

You still intersect *each* syscall, why not to do the same for 
epoll_wait()
and replace events with correct value?  Seems you do something similar 
already
in a vu_wrap_poll.c: wo_epoll_wait(), right?

Don't get me wrong, I really want to understand whether everything 
really
looks so bad without proposed change. It seems not, because the whole 
principle
is based on intersection of each syscall, thus one more one less - it 
does not
become more clean and especially does not look like a generic purpose 
solution,
which you seek.  I may be wrong.

--
Roman

