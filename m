Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19D6679F9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 05:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfG3Dt7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 23:49:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbfG3Dt7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:49:59 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67F442087F;
        Tue, 30 Jul 2019 03:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564458598;
        bh=37PshnNHyTKSRD1vHLM/mJAILgIXCFD7cY7PYklafH4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=BReYm/C3ktVX5tD52hjP5uATbZkaxNIsgtF8PEyxF2W4G9kZVs0hq5YsqX0Ly4UUH
         y7FAN4MpQgm1vbNxeNaS2aP2/RrdawE0C8+W3njVDnWC61FvSbJUagMZ+XCmucrWRS
         fT8HOlKnxh8QhWaFepCPOwYUfaHYOOQx1AA4oKLM=
Date:   Mon, 29 Jul 2019 20:49:56 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KEYS: Replace uid/gid/perm permissions checking with
 an ACL
Message-ID: <20190730034956.GB1966@sol.localdomain>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <155862710003.24863.11807972177275927370.stgit@warthog.procyon.org.uk>
 <155862710731.24863.14013725058582750710.stgit@warthog.procyon.org.uk>
 <20190710011559.GA7973@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710011559.GA7973@sol.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Tue, Jul 09, 2019 at 06:16:01PM -0700, Eric Biggers wrote:
> On Thu, May 23, 2019 at 04:58:27PM +0100, David Howells wrote:
> > Replace the uid/gid/perm permissions checking on a key with an ACL to allow
> > the SETATTR and SEARCH permissions to be split.  This will also allow a
> > greater range of subjects to represented.
> > 
> 
> This patch broke 'keyctl new_session', and hence broke all the fscrypt tests:
> 
> $ keyctl new_session
> keyctl_session_to_parent: Permission denied
> 
> Output of 'keyctl show' is
> 
> $ keyctl show
> Session Keyring
>  605894913 --alswrv      0     0  keyring: _ses
>  189223103 ----s-rv      0     0   \_ user: invocation_id
> 
> - Eric

This bug is still present in next-20190729.

- Eric
