Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DCC72A378
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 21:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjFITyM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 15:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjFITyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:54:06 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9984BE4A;
        Fri,  9 Jun 2023 12:53:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B069732007CF;
        Fri,  9 Jun 2023 15:53:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 09 Jun 2023 15:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686340434; x=1686426834; bh=/umth9x9wlDfRXa0nUo5a8OQ+XI1nihFMP9
        xQI+rJGQ=; b=kv51jI/2vQqJqWpRDRy6YebtnZrbRelWHznMXHZy1CaAeTWlV/B
        WUXMZ03NUHEGB+nIJYv6O/G70BKa2euupNcGt+Ji4dic3IgVTqiFFE19XVPc/1lt
        cyw+XZ0BcmWbPoqLNUhJvHrba73QtFdrTi8c5nYYdAm6MBoIVqNSq9iPK3fLqDX0
        +9NtqvFAL7gA+CHgtynVyz67z1G590yr4Jp4Fvu3NlemRcF/DLsJAJ5zhyl4wfeu
        ram0aLeLeGmLISnwX1ocuLv4sughwot4imhpion8eGYc19/SE3ZQ5EAq7XVAOFHx
        lq2k9tYC7kwlTGlQRMH5DfGZVMkOYuD7GZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686340434; x=1686426834; bh=/umth9x9wlDfRXa0nUo5a8OQ+XI1nihFMP9
        xQI+rJGQ=; b=Uu+uvnkQcizUN9SzSmORK1ZVPRc1KHi9XJ1W+5a9BilRllEL4Vq
        w0J6kvcqmE3QSHQbsqfVM6jIm3l/TQC1cWM0AJsGBpUS8Q08Fo8pupVisCUWXQQ4
        boJNfoEbkKbYYhC2go8SOYIOE9Xt40qNygpP2m6Fe5Qcs2HRuW4UxmvBsw9G7UKT
        QvPOxoEQBodTZQRnu8C+FzFnisHQd0eGIltjDJRx4IbZWhcd2J5o7wWL/3slY7Ee
        KmOP1OCyoi5PhEx7lghFGkh5lCwV5ui1mofbdqLjiowz2DFMcUliNgMyekiSBXe5
        Yzd3ltqfAUljxHJe6GmxI3dCg0VT8TlIB+g==
X-ME-Sender: <xms:UoODZCAtgazRSY8Z6sIpEsluds3u7gIcy7CPDRCqUFlFmAfp0b4p4w>
    <xme:UoODZMgSASOnJuSfd8owoWPHzm3-ZaNSwYTLEJ7woTxNTsAbNszAx3D_Psm-nFqFe
    O-Ig7HVhxCHKkShLQ>
X-ME-Received: <xmr:UoODZFkHFZb-00748ukm_TukYddbHZ8NbuB-6N2rGxEsK9xzk77ZbfDzSsruL6wRvfQhD00lR_b_P_YBDh4x7W4QulSPAuGP1U7MuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtkedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    eplefgkedvhfefjeetfedvvdekfeevfeffgeehtdeffeevheeigedvtedvgeduhefgnecu
    ffhomhgrihhnpehmihgtrhhoshhofhhtrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvsehr
    hihhlhdrihho
X-ME-Proxy: <xmx:UoODZAyDfQTZ0Cz2OU7nwmxKk6i69r1t4AZKKH3t6IpZuxgRhE8s7g>
    <xmx:UoODZHRYgSBr3nqU20Dt0hdJVWk1j4rwDEsKw9br464KUYB24sZHjA>
    <xmx:UoODZLZ9YbCcM88byX1GThjp7bq9pLMpsi1eKk__5FgIzD98NJr0Nw>
    <xmx:UoODZGEaFO1ZaLZOvYdAhNmUScguqDW3vLHA8c7tMFAnR5aeOAODEg>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jun 2023 15:53:52 -0400 (EDT)
Message-ID: <494331ec-4879-c751-a034-63d91e4d625a@ryhl.io>
Date:   Fri, 9 Jun 2023 21:53:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
Content-Language: en-US-large
To:     "Ariel Miculas (amiculas)" <amiculas@cisco.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Colin Walters <walters@verbum.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20230609063118.24852-1-amiculas@cisco.com>
 <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
 <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
 <6b90520e-c46b-4e0d-a1c5-fcbda42f8f87@betaapp.fastmail.com>
 <CH0PR11MB5299117F8EF192CA19A361ADCD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <d68eeeaf-17b7-77aa-cad5-2658e3ca2307@quicinc.com>
 <CH0PR11MB5299314EC8FB8645C90453B5CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <6896176b44d5e9675899403c88d82b1d1855311f.camel@HansenPartnership.com>
 <CH0PR11MB529969A40E91169B8CBDDB39CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <CH0PR11MB529969A40E91169B8CBDDB39CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/9/23 20:59, Ariel Miculas (amiculas) wrote:
> I did use git send-email for sending this patch series, but I cannot find any setting in the Outlook web client for disabling "top posting" when replying to emails:
> https://answers.microsoft.com/en-us/outlook_com/forum/all/eliminate-top-posting/5e1e5729-30f8-41e9-84cb-fb5e81229c7c
> 
> Regards,
> Ariel

You can also use git-send-email for sending replies. Just make a .txt 
file with this format:

Subject: <subject goes here>

<your reply after an empty line>

The lore.kernel.org site generates the appropriate git-send-email 
command for sending the reply, so you can copy-paste that to send it.

I send most of my replies like that.

> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> Sent: Friday, June 9, 2023 9:43 PM
> To: Ariel Miculas (amiculas); Trilok Soni; Colin Walters; Christian Brauner
> Cc: linux-fsdevel@vger.kernel.org; rust-for-linux@vger.kernel.org; linux-mm@kvack.org
> Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
> 
> On Fri, 2023-06-09 at 17:16 +0000, Ariel Miculas (amiculas) wrote:
>> I could switch to my personal gmail, but last time Miguel Ojeda asked
>> me to use my cisco email when I send commits signed off by
>> amiculas@cisco.com.
>> If this is not a hard requirement, then I could switch.
> 
> For sending patches, you can simply use git-send-email.  All you need
> to point it at is the outgoing email server (which should be a config
> setting in whatever tool you are using now).  We have a (reasonably) up
> to date document with some recommendations:
> 
> https://www.kernel.org/doc/html/latest/process/email-clients.html
> 
> I've successfully used evolution with an exchange server for many
> years, but the interface isn't to everyone's taste and Mozilla
> Thunderbird is also known to connect to it.  Basic outlook has proven
> impossible to configure correctly (which is why it doesn't have an
> entry).
> 
> Regards,
> 
> James
> 
