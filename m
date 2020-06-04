Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E48B1EDBF8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 05:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgFDD4m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 23:56:42 -0400
Received: from namei.org ([65.99.196.166]:40880 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgFDD4m (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 23:56:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0543uU8b003176;
        Thu, 4 Jun 2020 03:56:30 GMT
Date:   Thu, 4 Jun 2020 13:56:30 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Daniel Colascione <dancol@google.com>
cc:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk,
        Paul Moore <paul@paul-moore.com>, nnk@google.com,
        Stephen Smalley <sds@tycho.nsa.gov>, lokeshgidra@google.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 0/3] SELinux support for anonymous inodes and UFFD
In-Reply-To: <20200401213903.182112-1-dancol@google.com>
Message-ID: <alpine.LRH.2.21.2006041354381.1812@namei.org>
References: <20200326200634.222009-1-dancol@google.com> <20200401213903.182112-1-dancol@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 1 Apr 2020, Daniel Colascione wrote:

> Daniel Colascione (3):
>   Add a new LSM-supporting anonymous inode interface
>   Teach SELinux about anonymous inodes
>   Wire UFFD up to SELinux
> 
>  fs/anon_inodes.c                    | 191 ++++++++++++++++++++++------
>  fs/userfaultfd.c                    |  30 ++++-
>  include/linux/anon_inodes.h         |  13 ++
>  include/linux/lsm_hooks.h           |  11 ++
>  include/linux/security.h            |   3 +
>  security/security.c                 |   9 ++
>  security/selinux/hooks.c            |  53 ++++++++
>  security/selinux/include/classmap.h |   2 +
>  8 files changed, 267 insertions(+), 45 deletions(-)

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git secure_uffd_v5.9
and next-testing.

This will provide test coverage in linux-next, as we aim to get this 
upstream for v5.9.

I had to make some minor fixups, please review.


-- 
James Morris
<jmorris@namei.org>

