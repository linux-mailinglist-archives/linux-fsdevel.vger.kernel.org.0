Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B242174A44E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 21:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjGFTRd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 15:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjGFTRc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:17:32 -0400
Received: from sandeen.net (sandeen.net [63.231.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EEC31BD3;
        Thu,  6 Jul 2023 12:17:31 -0700 (PDT)
Received: from [10.0.0.71] (liberator.sandeen.net [10.0.0.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id C1A6E4EA2A8;
        Thu,  6 Jul 2023 14:17:29 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net C1A6E4EA2A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
        s=default; t=1688671049;
        bh=v4i+72g7D6iVCKKo2ymKFetMv3GnuiL/PAAAefQkWsM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hiKWH+L6yJHx5fVUwoip0hsaDM6VWhtZYBLYtvtqS0ZSOX2FyU7ByhQebtZP5pL5q
         woycrGQYJZJcOfinUYEI35vyvvoOj3axUDlTdOZsfQjqFED+6pMJnlmyJplY0Uvdl4
         liWnkn4XjJyqUgqFmrDNw32iBgrGZANTlAnPLtAY45V3GgvbSvbJw22dlo9IV23x54
         ZuzrKgIZnEsSKts3AQLUVrM3T0AYTz2cUbabIuvVWI92hN/Cn5hKe6cRB9dclyBKNJ
         cBhdTs/9n+qxbfLgOFlkcjptd5Q49JrZC0SYZyn7j4YRumIIYXo7ma2pF1ISp2Si99
         JWrvhqLeigZfg==
Message-ID: <d2a06111-c8c6-cdb6-c8ac-ae7148742786@sandeen.net>
Date:   Thu, 6 Jul 2023 14:17:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        djwong@kernel.org, dchinner@redhat.com, sandeen@redhat.com,
        willy@infradead.org, tytso@mit.edu, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230706164055.GA2306489@perftesting>
 <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
From:   Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/6/23 12:38 PM, Kent Overstreet wrote:
> Right now what I'm hearing, in particular from Redhat, is that they want
> it upstream in order to commit more resources. Which, I know, is not
> what kernel people want to hear, but it's the chicken-and-the-egg
> situation I'm in.

I need to temper that a little. Folks in and around filesystems and 
storage at Red Hat find bcachefs to be quite compelling and interesting, 
and we've spent some resources in the past several months to 
investigate, test, benchmark, and even do some bugfixing.

Upstream acceptance is going to be a necessary condition for almost any 
distro to consider shipping or investing significantly in bcachefs. But 
it's not a given that once it's upstream we'll immediately commit more 
resources - I just wanted to clarify that.

It is a tough chicken and egg problem to be sure. That said, I think 
you're right Kent - landing it upstream will quite likely encourage more 
interest, users, and hopefully developers.

Maybe it'd be reasonable to mark bcachefs as EXPERIMENTAL or similar in 
Kconfig, documentation, and printks - it'd give us options in case it 
doesn't attract developers and Kent does get hit by a bus or decide to 
go start a goat farm instead (i.e. in the worst case, it could be 
yanked, having set expectations.)

-Eric
