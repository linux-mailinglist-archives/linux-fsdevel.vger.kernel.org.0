Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2BC21651E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 22:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBSVsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 16:48:40 -0500
Received: from mail.hallyn.com ([178.63.66.53]:41866 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgBSVsj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:48:39 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 947E77DD; Wed, 19 Feb 2020 15:48:37 -0600 (CST)
Date:   Wed, 19 Feb 2020 15:48:37 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 00/25] user_namespace: introduce fsid mappings
Message-ID: <20200219214837.GA29159@mail.hallyn.com>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
 <20200219193558.GA27641@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219193558.GA27641@mail.hallyn.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:35:58PM -0600, Serge E. Hallyn wrote:
> On Tue, Feb 18, 2020 at 03:33:46PM +0100, Christian Brauner wrote:
> > With fsid mappings we can solve this by writing an id mapping of 0
> > 100000 100000 and an fsid mapping of 0 300000 100000. On filesystem
> > access the kernel will now lookup the mapping for 300000 in the fsid
> > mapping tables of the user namespace. And since such a mapping exists,
> > the corresponding files will have correct ownership.
> 
> So if I have
> 
> /proc/self/uid_map: 0 100000 100000
> /proc/self/fsid_map: 1000 1000 1

Oh, sorry.  Your explanation in 20/25 i think set me straight, though I need
to think through a few more examples.

...

> 3. If I create a new file, as nsuid 1000, what will be the inode owning kuid?

(Note - I edited the quoted txt above to be more precise)

I'm still not quite clear on this.  I believe the fsid mapping will take
precedence so it'll be uid 1000 ?  Per mount behavior would be nice there,
but perhaps unwieldy.
