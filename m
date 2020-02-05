Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8FE152591
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 05:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgBEEVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 23:21:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47498 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgBEEVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 23:21:42 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 694AB29298E
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v6 1/5] unicode: Add standard casefolded d_ops
Organization: Collabora
References: <20200128230328.183524-1-drosen@google.com>
        <20200128230328.183524-2-drosen@google.com>
        <85sgjsxx2g.fsf@collabora.com>
        <CA+PiJmS3kbK8220QaccP5jJ7dSf4xv3UrStQvLskAtCN+=vG_A@mail.gmail.com>
Date:   Tue, 04 Feb 2020 23:21:33 -0500
In-Reply-To: <CA+PiJmS3kbK8220QaccP5jJ7dSf4xv3UrStQvLskAtCN+=vG_A@mail.gmail.com>
        (Daniel Rosenberg's message of "Tue, 4 Feb 2020 19:05:02 -0800")
Message-ID: <85h8051x6a.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Daniel Rosenberg <drosen@google.com> writes:

> On Sun, Feb 2, 2020 at 5:46 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
>>
>>
>> I don't think fs/unicode is the right place for these very specific
>> filesystem functions, just because they happen to use unicode.  It is an
>> encoding library, it doesn't care about dentries, nor should know how to
>> handle them.  It exposes a simple api to manipulate and convert utf8 strings.
>>
>> I saw change was after the desire to not have these functions polluting
>> the VFS hot path, but that has nothing to do with placing them here.
>>
>> Would libfs be better?  or a casefolding library in fs/casefold.c?
>>
>>
>> --
>> Gabriel Krisman Bertazi
>
> The hash function needs access to utf8ncursor, but apart from that,
> libfs would make sense. utf8ncursor is the only reason I have them
> here. How do you feel about exposing utf8cursor or something similar?

Hi,

It was designed to be an internal thing, but I'm ok with exposing it.

-- 
Gabriel Krisman Bertazi
