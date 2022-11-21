Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46088632513
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 15:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiKUOHU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 09:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiKUOGp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:06:45 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215D5C7207;
        Mon, 21 Nov 2022 06:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1669039402;
        bh=S0ZSP+LpMvn5EG+QMrGCuiVBzAD0TgzklGkqSoGsMpY=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=LmOnMjf/PWybJ5EX60Fa9yOKxgTbOvaRNaY04/paLbN5uH4o4lPv4ZMxd1OjFSPog
         Jb7NDJz0ZFryHqV2O6+rSEhBsA6OMwneoaJQKNnz1xxYLQrFIAyv+iok9dE2vugAWJ
         Tb5oPQaOnH+VFy7FEgUaIo3Nvkw17Gh0THyBTrw0=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 747E11286581;
        Mon, 21 Nov 2022 09:03:22 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AUktWLsrhDZo; Mon, 21 Nov 2022 09:03:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1669039402;
        bh=S0ZSP+LpMvn5EG+QMrGCuiVBzAD0TgzklGkqSoGsMpY=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=LmOnMjf/PWybJ5EX60Fa9yOKxgTbOvaRNaY04/paLbN5uH4o4lPv4ZMxd1OjFSPog
         Jb7NDJz0ZFryHqV2O6+rSEhBsA6OMwneoaJQKNnz1xxYLQrFIAyv+iok9dE2vugAWJ
         Tb5oPQaOnH+VFy7FEgUaIo3Nvkw17Gh0THyBTrw0=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A207B1286558;
        Mon, 21 Nov 2022 09:03:20 -0500 (EST)
Message-ID: <10c85b8f4779700b82596c4a968daead65a29801.camel@HansenPartnership.com>
Subject: Re: [PATCH 2/4] fs: define a firmware security filesystem named
 fwsecurityfs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nayna <nayna@linux.vnet.ibm.com>, Nayna Jain <nayna@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-efi@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, Dov Murik <dovmurik@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Russell Currey <ruscur@russell.cc>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Mon, 21 Nov 2022 09:03:18 -0500
In-Reply-To: <Y3tbhmL4oG1YTyT/@kroah.com>
References: <20221106210744.603240-1-nayna@linux.ibm.com>
         <20221106210744.603240-3-nayna@linux.ibm.com> <Y2uvUFQ9S2oaefSY@kroah.com>
         <8447a726-c45d-8ebb-2a74-a4d759631e64@linux.vnet.ibm.com>
         <Y2zLRw/TzV/sWgqO@kroah.com>
         <44191f02-7360-bca3-be8f-7809c1562e68@linux.vnet.ibm.com>
         <Y3anQukokMcQr+iE@kroah.com>
         <d615180d-6fe5-d977-da6a-e88fd8bf5345@linux.vnet.ibm.com>
         <Y3pSF2MRIXd6aH14@kroah.com>
         <88111914afc6204b2a3fb82ded5d9bfb6420bca6.camel@HansenPartnership.com>
         <Y3tbhmL4oG1YTyT/@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-11-21 at 12:05 +0100, Greg Kroah-Hartman wrote:
> On Sun, Nov 20, 2022 at 10:14:26PM -0500, James Bottomley wrote:
> > On Sun, 2022-11-20 at 17:13 +0100, Greg Kroah-Hartman wrote:
> > > On Sat, Nov 19, 2022 at 01:20:09AM -0500, Nayna wrote:
> > > > 
> > > > On 11/17/22 16:27, Greg Kroah-Hartman wrote:
> > > > > On Mon, Nov 14, 2022 at 06:03:43PM -0500, Nayna wrote:
> > > > > > On 11/10/22 04:58, Greg Kroah-Hartman wrote:
> > [...]
> > > > > > > I do not understand, sorry.  What does namespaces have to
> > > > > > > do
> > > > > > > with this?
> > > > > > > sysfs can already handle namespaces just fine, why not
> > > > > > > use
> > > > > > > that?
> > > > > > Firmware objects are not namespaced. I mentioned it here as
> > > > > > an
> > > > > > example of the difference between firmware and kernel
> > > > > > objects.
> > > > > > It is also in response to the feedback from James Bottomley
> > > > > > in
> > > > > > RFC v2 [
> > > > > > https://lore.kernel.org/linuxppc-dev/41ca51e8db9907d9060cc38ad
> > > > > > b59a66dcae4c59b.camel@HansenPartnership.com/].
> > > > > I do not understand, sorry.  Do you want to use a namespace
> > > > > for
> > > > > these or not?  The code does not seem to be using
> > > > > namespaces. 
> > > > > You can use sysfs with, or without, a namespace so I don't
> > > > > understand the issue here.
> > > > > 
> > > > > With your code, there is no namespace.
> > > > 
> > > > You are correct. There's no namespace for these.
> > > 
> > > So again, I do not understand.  Do you want to use filesystem
> > > namespaces, or do you not?
> > 
> > Since this seems to go back to my email quoted again, let me
> > repeat: the question isn't if this patch is namespaced; I think
> > you've agreed several times it isn't.  The question is if the
> > exposed properties would ever need to be namespaced.  This is a
> > subtle and complex question which isn't at all explored by the
> > above interchange.
> > 
> > > How again can you not use sysfs or securityfs due to namespaces? 
> > > What is missing?
> > 
> > I already explained in the email that sysfs contains APIs like
> > simple_pin_... which are completely inimical to namespacing.
> 
> Then how does the networking code handle the namespace stuff in
> sysfs?
> That seems to work today, or am I missing something?

have you actually tried?

jejb@lingrow:~> sudo unshare --net bash
lingrow:/home/jejb # ls /sys/class/net/
lo  tun0  tun10  wlan0
lingrow:/home/jejb # ip link show
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group
default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00

So, as you see, I've entered a network namespace and ip link shows me
the only interface I can see in that namespace (a down loopback) but
sysfs shows me every interface on the system outside the namespace.

This is pretty much the story of containers and sysfs: if you mount it
inside the container, it leaks information about the host
configuration.  Since I created a container with full root, I could
actually fiddle with the host network parameters on interfaces I
shouldn't be able to see within the container using sysfs ... which is
one reason we try to persuade people to use a user namespace instead of
full root.
 
> If the namespace support needs to be fixed up in sysfs (or in
> securityfs), then great, let's do that, and not write a whole new
> filesystem just because that's not done.

As I said: a fix is proposed for securityfs.  I think everyone in
containers concluded long ago that sysfs is too big an Augean Stable.

> Also this patch series also doesn't handle namespaces, so again, I am
> totally confused as to why this is even being discussed...

Well, it's not my patch.  I came into this saying *if* there was ever a
reason to namespace these parameters then please don't use interfaces
inimical to namespacing.  My personal view is that this should all just
go in securityfs because that defers answering the question of whether
it would eventually be namespaced.

James

