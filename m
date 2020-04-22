Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4ED1B4B0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 18:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgDVQzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 12:55:41 -0400
Received: from namei.org ([65.99.196.166]:52066 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbgDVQzl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:55:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 03MGtWHf013311;
        Wed, 22 Apr 2020 16:55:32 GMT
Date:   Thu, 23 Apr 2020 02:55:32 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Daniel Colascione <dancol@google.com>
cc:     Tim Murray <timmurray@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Lokesh Gidra <lokeshgidra@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v5 0/3] SELinux support for anonymous inodes and UFFD
In-Reply-To: <CAKOZueuu=bGt4O0xjiV=9_PC_8Ey8pa3NjtJ7+O-nHCcYbLnEg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2004230253530.12318@namei.org>
References: <20200326200634.222009-1-dancol@google.com> <20200401213903.182112-1-dancol@google.com> <CAKOZueuu=bGt4O0xjiV=9_PC_8Ey8pa3NjtJ7+O-nHCcYbLnEg@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 13 Apr 2020, Daniel Colascione wrote:

> On Wed, Apr 1, 2020 at 2:39 PM Daniel Colascione <dancol@google.com> wrote:
> >
> > Changes from the fourth version of the patch:
> 
> 
> Is there anything else that needs to be done before merging this patch series?

The vfs changes need review and signoff from the vfs folk, the SELinux 
changes by either Paul or Stephen, and we also need signoff on the LSM 
hooks from other major LSM authors (Casey and John, at a minimum).


-- 
James Morris
<jmorris@namei.org>

