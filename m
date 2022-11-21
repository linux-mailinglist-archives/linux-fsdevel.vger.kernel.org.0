Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68CE632B13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 18:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiKUReE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 12:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiKUReD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:34:03 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C34CD969;
        Mon, 21 Nov 2022 09:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1669052039;
        bh=1NBtM3ic574n1Twrt+hz9W3YFOsRlGAK5kI5ykv3AJw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=hfMHqNKVYci9A6OL7RrPHVSj1+fjQqUesByvXCWTpD4VnwLtv5YDW1JRN8Csya7op
         uLgPvLjaO2YbSOjN4wYahNIyWUkxX5TlI1+QLg3WaWhlujBxrtFTHrqy/uEngA/y2n
         4d9ObYfWnPQFfG5r8u+cQVwMFWtQgcYi6z4E0Xh8=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 29B2B128647B;
        Mon, 21 Nov 2022 12:33:59 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Xzyyntl5lLVC; Mon, 21 Nov 2022 12:33:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1669052038;
        bh=1NBtM3ic574n1Twrt+hz9W3YFOsRlGAK5kI5ykv3AJw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=HoHMad2SLqp4HlUabcI9OV4eBb+9yM/KrRBmYc1yGrB3+7iRYKajqVC0FUeOCYulg
         2XSfo2Ri/bc34rVnRpsXaX+LQpt123Zr9A2/dIVlxcff7qs5iYpgrK4abJ8D8k8uTb
         m7TFERR+spJqRcqq+FeAE6mRuyUxoiJWyP8Om2HA=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 74E4812862F9;
        Mon, 21 Nov 2022 12:33:57 -0500 (EST)
Message-ID: <94fe007e8eab8bc7ae3f56b88ad94646b4673657.camel@HansenPartnership.com>
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
Date:   Mon, 21 Nov 2022 12:33:55 -0500
In-Reply-To: <Y3uT0PJ5g86TAj6t@kroah.com>
References: <Y2uvUFQ9S2oaefSY@kroah.com>
         <8447a726-c45d-8ebb-2a74-a4d759631e64@linux.vnet.ibm.com>
         <Y2zLRw/TzV/sWgqO@kroah.com>
         <44191f02-7360-bca3-be8f-7809c1562e68@linux.vnet.ibm.com>
         <Y3anQukokMcQr+iE@kroah.com>
         <d615180d-6fe5-d977-da6a-e88fd8bf5345@linux.vnet.ibm.com>
         <Y3pSF2MRIXd6aH14@kroah.com>
         <88111914afc6204b2a3fb82ded5d9bfb6420bca6.camel@HansenPartnership.com>
         <Y3tbhmL4oG1YTyT/@kroah.com>
         <10c85b8f4779700b82596c4a968daead65a29801.camel@HansenPartnership.com>
         <Y3uT0PJ5g86TAj6t@kroah.com>
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

On Mon, 2022-11-21 at 16:05 +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 21, 2022 at 09:03:18AM -0500, James Bottomley wrote:
> > On Mon, 2022-11-21 at 12:05 +0100, Greg Kroah-Hartman wrote:
> > > On Sun, Nov 20, 2022 at 10:14:26PM -0500, James Bottomley wrote:
[...]
> > > > I already explained in the email that sysfs contains APIs like
> > > > simple_pin_... which are completely inimical to namespacing.
> > > 
> > > Then how does the networking code handle the namespace stuff in
> > > sysfs? That seems to work today, or am I missing something?
> > 
> > have you actually tried?
> > 
> > jejb@lingrow:~> sudo unshare --net bash
> > lingrow:/home/jejb # ls /sys/class/net/
> > lo  tun0  tun10  wlan0
> > lingrow:/home/jejb # ip link show
> > 1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT
> > group
> > default qlen 1000
> >     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> > 
> > So, as you see, I've entered a network namespace and ip link shows
> > me the only interface I can see in that namespace (a down loopback)
> > but sysfs shows me every interface on the system outside the
> > namespace.
> 
> Then all of the code in include/kobject_ns.h is not being used?  We
> have a whole kobject namespace set up for networking, I just assumed
> they were using it.  If not, I'm all for ripping it out.

Hm, looking at the implementation, it seems to trigger off the
superblock (meaning you have to remount inside a mount namespace) and
it only works to control visibility in label based namespaces, so this
does actually work

jejb@lingrow:~/git/linux> sudo unshare  --net --mount bash 
lingrow:/home/jejb # mount -t sysfs none /sys
lingrow:/home/jejb # ls /sys/class/net/
lo

The label based approach means that any given file can be shown in one
and only one namespace, which works for net, but not much else
(although it probably could be adapted).

James

