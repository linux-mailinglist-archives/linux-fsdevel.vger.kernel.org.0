Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D443454C09B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 06:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiFOEWp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 00:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbiFOEWl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 00:22:41 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9E410FF5
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 21:22:38 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25F4MYrF014225
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jun 2022 00:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1655266955; bh=GaCulJnfo5iXBqtblbk9G1Lk4SsnNzEvugTOCcxnIdQ=;
        h=Date:From:To:Subject;
        b=b2j9CnFafC/KNrTWMuGLecm/3KIjPMlxU2R9y9v9yAhsBmd4HqS3uAXCrKqHRY7g8
         3qWD2lz0MDp/4usg3HKfM9a98B5iNSITkzs0IcKyDVfSopPX2MPWCbdHwz3Bvjndr8
         JWV36lLOo5c7L8yBroLkg5MLXztxL3fSdyajWgKd9bBfSCyLmRFLFeUiK9aVMj08e1
         0Wuv5N348eodhtPWonDHHhmeiNIowg3zCUjlvn3OkmAXebnlWX6ztF7AqTGfCm5uJ6
         ZdeEsTUMgjAv2Ml1MBKdVzvIHHaH4STHYb2DnnIeQRe8lj1yeliu+jIWhdfjeYS4s0
         /VpiEm8AuMvwg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2FB2415C42F8; Wed, 15 Jun 2022 00:22:34 -0400 (EDT)
Date:   Wed, 15 Jun 2022 00:22:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-fsdevel@vger.kernel.org
Subject: Maintainer's / Kernel Summit 2022 CFP
Message-ID: <YqleiqjGkeMHOawl@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This year, the Maintainer's Summit will be held in Dublin on September
15th, 2022, just after the Linux Plumber's Conference (September
12-14).

As in previous years, the Maintainers Summit is invite-only, where the
primary focus will be process issues around Linux Kernel Development.
It will be limited to 30 invitees and a handful of sponsored
attendees.

Linus will be generating a core list of people to be invited to the
Maintainers Summit.  The top ten people from that list will receive
invites, and then program committee will use the rest of Linus's list
as a starting point of people to be considered.  People who suggest
topics that should be discussed at the Maintainers Summit will also
be added to the list for consideration.  To make topic suggestions for
the Maintainers Summit, please send e-mail to the
ksummit-discuss@lists.linuxfoundation.org list with a subject prefix
of [MAINTAINERS SUMMIT].

The Kernel Summit is organized as a track which is run in parallel
with the other tracks at the Linux Plumbers Conference (LPC), and is
open to all registered attendees of LPC.  The goal of the Kernel
Summit track will be to provide a forum to discuss specific technical
issues that would be easier to resolve in person than over e-mail.
The program committee will also consider "information sharing" topics
if they are clearly of interest to the wider development community
(i.e., advanced training in topics that would be useful to kernel
developers).

To suggest a topic for the Kernel Summit, please do two things. by
June 19th, 2022.  First, please tag your e-mail with [TECH TOPIC].  As
before, please use a separate e-mail for each topic, and send the
topic suggestions to the ksummit-discuss list.

Secondly, please create a topic at the Linux Plumbers Conference
proposal submission site and target it to the Kernel Summit track:

	https://lpc.events/event/16/abstracts/

Please do both steps.  I'll try to notice if someone forgets one or
the other, but your chances of making sure your proposal gets the
necessary attention and consideration are maximized by submitting both
to the mailing list and the web site.

If you were not subscribed on to the kernel-discuss mailing list from
last year (or if you had removed yourself after the kernel summit),
you can subscribe to the discuss list using mailman:

   https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

The program committee this year is composed of the following people:

Greg KH
Jens Axboe
Ted Ts'o
Arnd Bergmann
Jon Corbet

