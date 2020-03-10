Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFAB17F21C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 09:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgCJInB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 04:43:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56739 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgCJInB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 04:43:01 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jBaTS-0000Pv-Jo; Tue, 10 Mar 2020 08:42:50 +0000
Date:   Tue, 10 Mar 2020 09:42:49 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/14] fsinfo: Allow the mount topology propogation flags
 to be retrieved [ver #18]
Message-ID: <20200310084249.itfnij6poyd7l4ar@wittgenstein>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376252176.344135.11226418366508725745.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <158376252176.344135.11226418366508725745.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 09, 2020 at 02:02:01PM +0000, David Howells wrote:
> Allow the mount topology propogation flags to be retrieved as part of the
> FSINFO_ATTR_MOUNT_INFO attributes.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

(Btw, I had a patchset for the old stat* family of syscalls a while back
https://lwn.net/ml/linux-fsdevel/20180418092722.20136-1-christian.brauner@ubuntu.com/)

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
