Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00B3D15BE4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 13:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgBMMLg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 07:11:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51758 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgBMMLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 07:11:35 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j2DLA-0000Ho-KK; Thu, 13 Feb 2020 13:11:32 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 52D7D1013A6; Thu, 13 Feb 2020 13:11:32 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arul Jeniston <arul.jeniston@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com,
        Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read function.
In-Reply-To: <CACAVd4iH3e+V3VTJhEOabn46mosL-ntOgjJm_mMjnnwKtcpAjw@mail.gmail.com>
Date:   Thu, 13 Feb 2020 13:11:32 +0100
Message-ID: <87zhdm1ybv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Arul,

Arul Jeniston <arul.jeniston@gmail.com> writes:

> Did you get a chance to update the timerfd man page?

Obviously not.

> Our customers are expecting these changes to happen asap.

You surely understand that both the kernel and the manpages are
available to you (Dell) free of charge.

If Dell provides these things under a commercial contract to customers,
then Dells customers surely can have expectations from Dell. But that's
none of my and any other contributors business.

If you need these changes ASAP, then either make them yourself or
contract someone who can do it for you.

Just making demands on a public mailing list in order to sort your
business problems is neither appropriate nor acceptable. You're neither
my boss nor do I have any contractual obligations with Dell.

You surely achieved something. The priority of this has moved right to
the bottom of my todo list. It's going to be worked on when I run out of
other things to fix or if I really get bored. Both won't happen anytime
soon.

Thanks,

        Thomas
