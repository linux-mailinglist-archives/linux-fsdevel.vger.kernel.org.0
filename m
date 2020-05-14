Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C10B1D35C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 18:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgENQAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 12:00:21 -0400
Received: from ms.lwn.net ([45.79.88.28]:48642 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgENQAV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 12:00:21 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CE4C772D;
        Thu, 14 May 2020 16:00:19 +0000 (UTC)
Date:   Thu, 14 May 2020 10:00:18 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Richard Weinberger <richard@nod.at>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v3 3/3] btrfs: document btrfs authentication
Message-ID: <20200514100018.1809465c@lwn.net>
In-Reply-To: <1363039146.219999.1589469276242.JavaMail.zimbra@nod.at>
References: <20200514092415.5389-1-jth@kernel.org>
        <20200514092415.5389-4-jth@kernel.org>
        <20200514062611.563ec1ea@lwn.net>
        <SN4PR0401MB3598FFE2AC30EA4E7B85533C9BBC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
        <1363039146.219999.1589469276242.JavaMail.zimbra@nod.at>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 14 May 2020 17:14:36 +0200 (CEST)
Richard Weinberger <richard@nod.at> wrote:

> But I have no idea what this orphan thingy is.

It suppresses a warning from Sphinx that the file is not included in the
docs build.  Mauro did that with a lot of his conversions just to make his
life easier at the time, but it's not really something we want going
forward.

jon
