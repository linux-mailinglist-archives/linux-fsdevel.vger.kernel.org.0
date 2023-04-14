Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3387D6E23A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 14:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjDNMxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 08:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjDNMxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:53:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21CF493F4;
        Fri, 14 Apr 2023 05:53:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DDBE2F4;
        Fri, 14 Apr 2023 05:53:57 -0700 (PDT)
Received: from [10.57.20.128] (unknown [10.57.20.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CBFA3F6C4;
        Fri, 14 Apr 2023 05:53:10 -0700 (PDT)
Message-ID: <8c4a011b-1274-a1ab-a058-a7362293d522@arm.com>
Date:   Fri, 14 Apr 2023 13:53:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 5/5] dnotify: Pass argument of fcntl_dirnotify as int
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@ACULAB.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Luca.Vizzarro@arm.com
References: <20230414100212.766118-1-Luca.Vizzarro@arm.com>
 <20230414100212.766118-6-Luca.Vizzarro@arm.com>
 <20230414104625.gyzuswldwil4jlfw@quack3>
From:   Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20230414104625.gyzuswldwil4jlfw@quack3>
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

On 14/04/2023 11:46, Jan Kara wrote:
> Looks good to me. Do you plan to merge this series together (perhaps
> Christian could?) or should I pick up the dnotify patch? In case someone
> else will merge the patch feel free to add:
> 
> Acked-by: Jan Kara <jack@suse.cz>

Hi Jan! Thank you for your review! The patches could potentially be 
merged separately, as they should work independently.
