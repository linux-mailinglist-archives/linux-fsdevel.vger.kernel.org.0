Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A733F981E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 12:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244708AbhH0K1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 06:27:33 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:32804 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbhH0K1c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 06:27:32 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJZ05-00GToP-0I; Fri, 27 Aug 2021 10:22:17 +0000
Date:   Fri, 27 Aug 2021 10:22:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: audit watch and kernfs
Message-ID: <YSi82KJuaTFQU/68@zeniv-ca.linux.org.uk>
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-10-krisman@collabora.com>
 <CAOQ4uxi7otGo6aNNMk9-fVQCx4Q0tDFe7sJaCr6jj1tNtfExTg@mail.gmail.com>
 <87tujdz7u7.fsf@collabora.com>
 <CAOQ4uxhj=UuvT5ZonFD2sgufqWrF9m4XJ19koQ5390GUZ32g7g@mail.gmail.com>
 <87mtp5yz0q.fsf@collabora.com>
 <CAOQ4uxjnb0JmKVpMuEfa_NgHmLRchLz_3=9t2nepdS4QXJ=QVg@mail.gmail.com>
 <CAHC9VhT9SE6+kLYBh2d7CW5N6RCr=_ryK+ncGvqYJ51B7_egPA@mail.gmail.com>
 <CAOQ4uxgDdNsSHj4T8Ugr1_WTZgDpGcVMnNMqVVNFnVWvYcX4eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgDdNsSHj4T8Ugr1_WTZgDpGcVMnNMqVVNFnVWvYcX4eQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 12:36:23PM +0300, Amir Goldstein wrote:

> I did not check if it is possible or easy to d_instantiate() in kernfs
> mkdir() etc like other filesystems do and I do not know if it would be
> possible to enforce that as a strict vfs API rather than a recommendation.

For the second question: it would not.  E.g. a network filesystem has every
right not to give you the data you would need to set an inode up - just
"your mkdir had been successful".
