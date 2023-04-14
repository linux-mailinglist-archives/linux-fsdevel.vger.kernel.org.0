Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DF56E23B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 14:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDNMzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 08:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDNMzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:55:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0076BBA8;
        Fri, 14 Apr 2023 05:54:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A0EC4B3;
        Fri, 14 Apr 2023 05:55:40 -0700 (PDT)
Received: from [10.57.20.128] (unknown [10.57.20.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03D943F6C4;
        Fri, 14 Apr 2023 05:54:53 -0700 (PDT)
Message-ID: <3a43f6f8-c34e-72a3-f7c2-7dde96e54e59@arm.com>
Date:   Fri, 14 Apr 2023 13:54:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 0/5] Alter fcntl to handle int arguments correctly
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@ACULAB.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org,
        Luca Vizzarro <Luca.Vizzarro@arm.com>
References: <20230414100212.766118-1-Luca.Vizzarro@arm.com>
 <20230414-krumm-dekorativ-60ed7358b587@brauner>
From:   Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20230414-krumm-dekorativ-60ed7358b587@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/04/2023 13:37, Christian Brauner wrote
> Fyi, this blurb at the end breaks applying this series.
> 
> It means when someone pulls these patches down they get corrupted git
> patches. You should fix your setup to not have this nonsense in your
> mails. I tried to apply this for review to v6.2 up until v6.3-mainline
> until I realized that the patches are corrupted by the blurb at the
> end...

Apologies! There was an error in my end with the selection of the SMTP 
server. That was definitely not meant to be there! Will make sure to 
repost correctly.
