Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031B26020E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 04:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiJRCJQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 22:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJRCIq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:08:46 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682603844E;
        Mon, 17 Oct 2022 19:08:33 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 31EC35C018A;
        Mon, 17 Oct 2022 22:07:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 17 Oct 2022 22:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1666058842; x=
        1666145242; bh=bTvWLcvh9ljVlRrZI2X/bXzwu0U/f0+Pt0Mz34zZoEI=; b=C
        iSOXLdx3y9KEX3qCsTr1PTUjNSBkeWIpN4mqk2bcxznHQJ6CFURsIlz7deN8+ncK
        GIbE7nUjZz5vAjGksm93QuM845/PsKv9r7FkK3oaVc1evQxr6HFscmaSF7PtiqS5
        iq5HgrBo0CQCq4DV0VTc3H7ak4zwQRxEuZjNRH+Oqa1BcCCIggDtb+PdpNbxcsS3
        1svwDfOQa153w7onrEVorQGJ7B2qWdDb+SWtKzLvkyNHWaXDpSiv0B7c8aNrY81W
        Bijy+9WPzIjaHh0v5Lv7iZCIpN2A1Aw854WG2xzSSNqZ4fX5H3KRN8VAh+V3LwKE
        hjxbrT7Xq+DvOqRB4eXBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666058842; x=
        1666145242; bh=bTvWLcvh9ljVlRrZI2X/bXzwu0U/f0+Pt0Mz34zZoEI=; b=U
        vVIGswq7gmKtiZWcWeiymZDBBfOJJFUzlEPNh55/8/S2t7WkpxokUi7+MSs+kBo0
        7LzwQOkAj6D/46BQeVqpf64MqEGfx3C7XUB99DyCOeOOig1M9KFGBIkESSwfpTrA
        r3a3X0NvhEQTfL5Lhw8N5Mirmu7gQKXlaAYD2BgQi9y5NJcmgiKsxpvGYC2xM7Ib
        r4GyZhSxZ/DXcL57NQLiWddY1yAdnSoTyfIWlhqoOzkzUt5D9JAkQeJaSYEjbDA/
        StpYQfllutPQrFmF+hs6j1xahGr1Hcwxh8SFOzU91vjZggFgKWTFgV/A0MpQhyg0
        V2wlnwJ31/tury3P1/VWQ==
X-ME-Sender: <xms:WQpOY2ycRniINz-gGIZAaRd_dRhY9krgkRIGe2eh2lIcSqqtd4sFDg>
    <xme:WQpOYyS-H8o1FDU3OXQcMgPZti-vPwmhbk6Rgmjb_AQv-jLO8aOwpW62lZahYfKiC
    b7L86n_ymfk>
X-ME-Received: <xmr:WQpOY4Wl6Az-5DWOCuGjH6kxojNieJtLlTBt4MSKCOOgZf26NVVrwZKc0H1esBj0DrzfEVfrOUUXF3X255aeArwW29n9rJlV-uuy1u_VdcmJ3hlnrmE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeltddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:WQpOY8hjQ7XiwIEoOQ2EQ7AvXUgU6cVY0RGNRvYeOIaduW83cCaoew>
    <xmx:WQpOY4Dw-mEc9_nZ8qz72XW1VDG5jf4lvjVbgocMxW9BAZFJdi04lQ>
    <xmx:WQpOY9IC0mKwPdZMllEnvjrtFEEGSfAZdHSKQfIzDUG_xV48KjFxyw>
    <xmx:WgpOY34KUAA70J5-LJWcZ-nRnEinFsr9dBMWJMirLCaLdGLMZ_nNsg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Oct 2022 22:07:18 -0400 (EDT)
Message-ID: <cf9a666c-e663-fb9e-ba3f-4052edf17536@themaw.net>
Date:   Tue, 18 Oct 2022 10:07:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [REPOST PATCH v3 2/2] vfs: parse: deal with zero length string
 value
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <166365872189.39016.10771273319597352356.stgit@donald.themaw.net>
 <166365878918.39016.12757946948158123324.stgit@donald.themaw.net>
 <20221017185523.22f43b5d7f9fee1e1e3d872f@linux-foundation.org>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <20221017185523.22f43b5d7f9fee1e1e3d872f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 18/10/22 09:55, Andrew Morton wrote:
> On Tue, 20 Sep 2022 15:26:29 +0800 Ian Kent <raven@themaw.net> wrote:
>
>> Parsing an fs string that has zero length should result in the parameter
>> being set to NULL so that downstream processing handles it correctly.
>> For example, the proc mount table processing should print "(none)" in
>> this case to preserve mount record field count, but if the value points
>> to the NULL string this doesn't happen.
>>
>> ...
>>
>> --- a/fs/fs_parser.c
>> +++ b/fs/fs_parser.c
>> @@ -197,6 +197,8 @@ int fs_param_is_bool(struct p_log *log, const struct fs_parameter_spec *p,
>>   		     struct fs_parameter *param, struct fs_parse_result *result)
>>   {
>>   	int b;
>> +	if (param->type == fs_value_is_empty)
>> +		return 0;
>>   	if (param->type != fs_value_is_string)
>>   		return fs_param_bad_value(log, param);
>>   	if (!*param->string && (p->flags & fs_param_can_be_empty))
>> @@ -213,6 +215,8 @@ int fs_param_is_u32(struct p_log *log, const struct fs_parameter_spec *p,
>>   		    struct fs_parameter *param, struct fs_parse_result *result)
>>   {
>>   	int base = (unsigned long)p->data;
>> +	if (param->type == fs_value_is_empty)
>> +		return 0;
>>   	if (param->type != fs_value_is_string)
>>   		return fs_param_bad_value(log, param);
>>   	if (!*param->string && (p->flags & fs_param_can_be_empty))
>>
>> [etcetera]
> This feels wrong.  Having to check for fs_value_is_empty in so many
> places makes me think "we just shouldn't have got this far".  Am I
> right for once?


Maybe, did you have a different approach in mind ... ?


My thought was that these helper functions need to protect themselves

against things that could creep in and we don't know what they may be.


I'm not sure the best strategy is to not ever do this type of call in 
the first

place ...


Ian

