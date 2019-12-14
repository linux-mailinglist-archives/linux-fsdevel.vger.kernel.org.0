Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C6011F1A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2019 12:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfLNL46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Dec 2019 06:56:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55955 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfLNL46 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Dec 2019 06:56:58 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ig62Z-0005xt-6W; Sat, 14 Dec 2019 11:56:55 +0000
Date:   Sat, 14 Dec 2019 12:56:54 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 0/1] preparatory patch for a uid/gid shifting bind mount
Message-ID: <20191214115653.sciufxtj7ynwa7vy@wittgenstein>
References: <1575148763.5563.28.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1575148763.5563.28.camel@HansenPartnership.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 30, 2019 at 01:19:23PM -0800, James Bottomley wrote:
> I had another look at what it would take to reimplement shiftfs as a
> true bind mount.  It turns out we do have struct path threaded in
> almost enough places to make it work.  There really is only one API
> that needs updating and that's notify_change(), so the following patch
> fixes that and pulls do_truncate() along as well.  The updates are
> mostly smooth and pretty obvious because the path was actually already
> present, except for in overlayfs where trying to sort out what the path
> should be is somewhat of a nightmare.  If the overlayfs people could
> take a look and make sure I got it right, I'd be grateful.
> 
> I think this is the only needed change, but I've only just got a
> functional implementation of a uid/gid shifting bind mount, so there
> might be other places that need rethreading as I find deficiencies in
> the current implementation.  I'll send them along as additional patches
> if I find them

Thanks for the patch. Can you please make sure to Cc the following
people who attended the dedicated shiftfs session together with you at
LPC in Lisbon for v2? They're all major stackholders in this:

Stéphane Graber <stgraber@ubuntu.com>
Eric Biederman <ebiederm@xmission.com>
David Howells <dhowells@redhat.com>
Aleksa Sarai <cyphar@cyphar.com>
Christian Brauner <christian.brauner@ubuntu.com>

(I haven't gotten around to looking at the initial bind mount patchset
you sent out about two weeks ago. Pre-holidays it's always tricky to
find time for proper reviews...)

Christian
