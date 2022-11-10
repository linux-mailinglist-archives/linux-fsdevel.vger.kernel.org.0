Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EA36249CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 19:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiKJSoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 13:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiKJSoF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:44:05 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4173E4E419;
        Thu, 10 Nov 2022 10:44:02 -0800 (PST)
Received: from letrec.thunk.org ([12.195.131.130])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2AAIhr4H032119
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 13:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1668105836; bh=OxV/wPBI/elvo9RqU1x8K/upLC1u9AVLuFEhDBZI3/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=izNxFJcRuUt8w5tR0g+G2Rui48FmQk+fNvNBWGUSRQLAOfQyjwnh2zolSwJlw7wG7
         Wa7K0kLrquhZoGtoKHAJ1HXzKXR77h5scPIup3RoGz+OEIK6KXvwoaCt8XcQjtEtyi
         YRMhiH58DF+n/hatbQ8rOIV9Vb23bRcfcPXtywNha7qNfdyJw4+0AJXAOlN3bkNcfC
         LrOJnzdaa597rR9Z6Mkv7fkAOUSZd83saq+nlY0Q1xO2Qnnfx9I7UK2p8J4k8HnXj6
         vikyqACqQBCmBA8lasgQwb09ZMYDW01ZnYRSvqd2XynBa1h9Wl/zDamKye2Ay5IqSP
         yAQGSKrGF9sww==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 624158C02C6; Thu, 10 Nov 2022 13:43:53 -0500 (EST)
Date:   Thu, 10 Nov 2022 13:43:53 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Niels de Vos <ndevos@redhat.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Marcel Lauhoff <marcel.lauhoff@suse.com>
Subject: Re: [RFC 0/4] fs: provide per-filesystem options to disable fscrypt
Message-ID: <Y21GaVgkoeWOPFO4@mit.edu>
References: <20221110141225.2308856-1-ndevos@redhat.com>
 <Y20a/akbY8Wcy3qg@mit.edu>
 <Y20rDl45vSmdEo3N@ndevos-x1>
 <Y20/ynxvIqOyRbxK@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y20/ynxvIqOyRbxK@mit.edu>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 10, 2022 at 01:15:38PM -0500, Theodore Ts'o wrote:
> On Thu, Nov 10, 2022 at 05:47:10PM +0100, Niels de Vos wrote:
> > And, there actually are options like CONFIG_EXT4_FS_POSIX_ACL and
> > CONFIG_EXT4_FS_SECURITY. Because these exist already, I did not expect
> > too much concerns with proposing a CONFIG_EXT4_FS_ENCRYPTION...
> 
> Actually, I was thinking of getting rid of them, as we've already
> gotten rid of EXT4_FS_POSIX_ACL....

Sorry, I meant to say that we had gotten rid of EXT4_FS_XATTR.

	       	       	      	      	  - Ted
