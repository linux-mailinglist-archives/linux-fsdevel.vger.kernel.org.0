Return-Path: <linux-fsdevel+bounces-22318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EC391656B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38586281C8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 10:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE9F14A4DE;
	Tue, 25 Jun 2024 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PETeQVad"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC95146A61
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312139; cv=none; b=L2r3QNdhSKa5/hcUEPkwhMuMeewB15PXNbV3Qf5xmuXo9ieVrHdoODEr0ARqj3VkAymCKjALwr6j5jfhejBIkSZKMpilUOH7ILsOCnfAnSCPFVuhshsC9vTYJEZaVosURZ7he7q6igJbnOrPypyCxJIRj3rJLShlDB80zNhxduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312139; c=relaxed/simple;
	bh=FImtEAzfnMtyfbHHY9sgtyFf29Dgwpx+1OokEwA7RJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRkPcojr6I4eLlhO7bDbOz42m2Xkiu6rTJsSl1MOGf9Z+W7oR6RAozYZkh9yKUR1UyMcdGZy4rb4+Pg9veXrAYCm6s7FyAyD8xiLxceDs+g/jGaMTaQ0WfxPKPF8tXguY5YDffYLtm8P95L+POl10WgQEdbTyGg8fn/r85u8e/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PETeQVad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886C1C4AF09;
	Tue, 25 Jun 2024 10:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719312138;
	bh=FImtEAzfnMtyfbHHY9sgtyFf29Dgwpx+1OokEwA7RJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PETeQVadFo7eIvSPLoJyRf9PIP4Qtoh15mXt8Yhki7rD8lDWoOr+bJSpGBIhhloDC
	 x0eXqAo02gEX/V4zOVSJ18ODWxZ7lEqzheWNRyfaDPODw8WTtfu/mbvyTBGKhmygln
	 yi7Cl+j2t+eRgWrDVP3bFtaFPS83KfLRZB0JdPmLZNTzccfNI+ZXhUpps7hwm6yaxX
	 rGUUiS8ZPoGm3nySrOMKrBTN4Un9EIbCwi5S8CcUiTEgKYhM/NaOoalZ4aVkWfLBDI
	 kpl2zvLldbVhCC2shwWinrnu56wHEzAi30/105b7ThD6arSJjALchgb/OjfKye0dqq
	 tE49veX+bxZ0A==
Date: Tue, 25 Jun 2024 12:42:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/4] Add the ability to query mount options in statmount
Message-ID: <20240625-tragbar-sitzgelegenheit-48f310320058@brauner>
References: <cover.1719257716.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1719257716.git.josef@toxicpanda.com>

On Mon, Jun 24, 2024 at 03:40:49PM GMT, Josef Bacik wrote:
> Hello,
> 
> Currently if you want to get mount options for a mount and you're using
> statmount(), you still have to open /proc/mounts to parse the mount options.
> statmount() does have the ability to store an arbitrary string however,
> additionally the way we do that is with a seq_file, which is also how we use
> ->show_options for the individual file systems.
> 
> Extent statmount() to have a flag for fetching the mount options of a mount.
> This allows users to not have to parse /proc mount for anything related to a
> mount.  I've extended the existing statmount() test to validate this feature
> works as expected.  As you can tell from the ridiculous amount of silly string
> parsing, this is a huge win for users and climate change as we will no longer
> have to waste several cycles parsing strings anymore.
> 
> This is based on my branch that extends listmount/statmount to walk into foreign
> namespaces.  Below are links to that posting, that branch, and this branch to
> make it easier to review.

So I was very hesitant to do it this way because I feel this is pretty
ugly dumping mount options like that but Karel and others have the same
use-case that they want to retrieve it all via statmount() (or another
ID-based system call) so I guess I'll live with this. But note that this
will be a fairly ugly interface at times. For example, mounting overlayfs with
500 lower layers then what one gets is:

/mnt/test
mnt_ns_id: 2
mnt_id: 4294969217
mnt_id_old: 820
mnt_parent_id: 4294967529
mnt_opts: rw,relatime,lowerdir+=/mnt/tmp1,
lowerdir+=/mnt/tmp2,lowerdir+=/mnt/tmp3,lowerdir+=/mnt/tmp4,lowerdir+=/mnt/tmp5,
lowerdir+=/mnt/tmp6,lowerdir+=/mnt/tmp7,lowerdir+=/mnt/tmp8,lowerdir+=/mnt/tmp9,
lowerdir+=/mnt/tmp10,lowerdir+=/mnt/tmp11,lowerdir+=/mnt/tmp12,
lowerdir+=/mnt/tmp13,lowerdir+=/mnt/tmp14,lowerdir+=/mnt/tmp15,
lowerdir+=/mnt/tmp16,lowerdir+=/mnt/tmp17,lowerdir+=/mnt/tmp18,
lowerdir+=/mnt/tmp19,lowerdir+=/mnt/tmp20,lowerdir+=/mnt/tmp21,
lowerdir+=/mnt/tmp22,lowerdir+=/mnt/tmp23,lowerdir+=/mnt/tmp24,
lowerdir+=/mnt/tmp25,lowerdir+=/mnt/tmp26,lowerdir+=/mnt/tmp27,
lowerdir+=/mnt/tmp28,lowerdir+=/mnt/tmp29,lowerdir+=/mnt/tmp30,
lowerdir+=/mnt/tmp31,lowerdir+=/mnt/tmp32,lowerdir+=/mnt/tmp33,
lowerdir+=/mnt/tmp34,lowerdir+=/mnt/tmp35,lowerdir+=/mnt/tmp36,
lowerdir+=/mnt/tmp37,lowerdir+=/mnt/tmp38,lowerdir+=/mnt/tmp39,
lowerdir+=/mnt/tmp40,lowerdir+=/mnt/tmp41,lowerdir+=/mnt/tmp42,
lowerdir+=/mnt/tmp43,lowerdir+=/mnt/tmp44,lowerdir+=/mnt/tmp45,
lowerdir+=/mnt/tmp46,lowerdir+=/mnt/tmp47,lowerdir+=/mnt/tmp48,
lowerdir+=/mnt/tmp49,lowerdir+=/mnt/tmp50,lowerdir+=/mnt/tmp51,
lowerdir+=/mnt/tmp52,lowerdir+=/mnt/tmp53,lowerdir+=/mnt/tmp54,
lowerdir+=/mnt/tmp55,lowerdir+=/mnt/tmp56,lowerdir+=/mnt/tmp57,
lowerdir+=/mnt/tmp58,lowerdir+=/mnt/tmp59,lowerdir+=/mnt/tmp60,
lowerdir+=/mnt/tmp61,lowerdir+=/mnt/tmp62,lowerdir+=/mnt/tmp63,
lowerdir+=/mnt/tmp64,lowerdir+=/mnt/tmp65,lowerdir+=/mnt/tmp66,
lowerdir+=/mnt/tmp67,lowerdir+=/mnt/tmp68,lowerdir+=/mnt/tmp69,
lowerdir+=/mnt/tmp70,lowerdir+=/mnt/tmp71,lowerdir+=/mnt/tmp72,
lowerdir+=/mnt/tmp73,lowerdir+=/mnt/tmp74,lowerdir+=/mnt/tmp75,
lowerdir+=/mnt/tmp76,lowerdir+=/mnt/tmp77,lowerdir+=/mnt/tmp78,
lowerdir+=/mnt/tmp79,lowerdir+=/mnt/tmp80,lowerdir+=/mnt/tmp81,
lowerdir+=/mnt/tmp82,lowerdir+=/mnt/tmp83,lowerdir+=/mnt/tmp84,
lowerdir+=/mnt/tmp85,lowerdir+=/mnt/tmp86,lowerdir+=/mnt/tmp87,
lowerdir+=/mnt/tmp88,lowerdir+=/mnt/tmp89,lowerdir+=/mnt/tmp90,
lowerdir+=/mnt/tmp91,lowerdir+=/mnt/tmp92,lowerdir+=/mnt/tmp93,
lowerdir+=/mnt/tmp94,lowerdir+=/mnt/tmp95,lowerdir+=/mnt/tmp96,
lowerdir+=/mnt/tmp97,lowerdir+=/mnt/tmp98,lowerdir+=/mnt/tmp99,
lowerdir+=/mnt/tmp100,lowerdir+=/mnt/tmp101,lowerdir+=/mnt/tmp102,
lowerdir+=/mnt/tmp103,lowerdir+=/mnt/tmp104,lowerdir+=/mnt/tmp105,
lowerdir+=/mnt/tmp106,lowerdir+=/mnt/tmp107,lowerdir+=/mnt/tmp108,
lowerdir+=/mnt/tmp109,lowerdir+=/mnt/tmp110,lowerdir+=/mnt/tmp111,
lowerdir+=/mnt/tmp112,lowerdir+=/mnt/tmp113,lowerdir+=/mnt/tmp114,
lowerdir+=/mnt/tmp115,lowerdir+=/mnt/tmp116,lowerdir+=/mnt/tmp117,
lowerdir+=/mnt/tmp118,lowerdir+=/mnt/tmp119,lowerdir+=/mnt/tmp120,
lowerdir+=/mnt/tmp121,lowerdir+=/mnt/tmp122,lowerdir+=/mnt/tmp123,
lowerdir+=/mnt/tmp124,lowerdir+=/mnt/tmp125,lowerdir+=/mnt/tmp126,
lowerdir+=/mnt/tmp127,lowerdir+=/mnt/tmp128,lowerdir+=/mnt/tmp129,
lowerdir+=/mnt/tmp130,lowerdir+=/mnt/tmp131,lowerdir+=/mnt/tmp132,
lowerdir+=/mnt/tmp133,lowerdir+=/mnt/tmp134,lowerdir+=/mnt/tmp135,
lowerdir+=/mnt/tmp136,lowerdir+=/mnt/tmp137,lowerdir+=/mnt/tmp138,
lowerdir+=/mnt/tmp139,lowerdir+=/mnt/tmp140,lowerdir+=/mnt/tmp141,
lowerdir+=/mnt/tmp142,lowerdir+=/mnt/tmp143,lowerdir+=/mnt/tmp144,
lowerdir+=/mnt/tmp145,lowerdir+=/mnt/tmp146,lowerdir+=/mnt/tmp147,
lowerdir+=/mnt/tmp148,lowerdir+=/mnt/tmp149,lowerdir+=/mnt/tmp150,
lowerdir+=/mnt/tmp151,lowerdir+=/mnt/tmp152,lowerdir+=/mnt/tmp153,
lowerdir+=/mnt/tmp154,lowerdir+=/mnt/tmp155,lowerdir+=/mnt/tmp156,
lowerdir+=/mnt/tmp157,lowerdir+=/mnt/tmp158,lowerdir+=/mnt/tmp159,
lowerdir+=/mnt/tmp160,lowerdir+=/mnt/tmp161,lowerdir+=/mnt/tmp162,
lowerdir+=/mnt/tmp163,lowerdir+=/mnt/tmp164,lowerdir+=/mnt/tmp165,
lowerdir+=/mnt/tmp166,lowerdir+=/mnt/tmp167,lowerdir+=/mnt/tmp168,
lowerdir+=/mnt/tmp169,lowerdir+=/mnt/tmp170,lowerdir+=/mnt/tmp171,
lowerdir+=/mnt/tmp172,lowerdir+=/mnt/tmp173,lowerdir+=/mnt/tmp174,
lowerdir+=/mnt/tmp175,lowerdir+=/mnt/tmp176,lowerdir+=/mnt/tmp177,
lowerdir+=/mnt/tmp178,lowerdir+=/mnt/tmp179,lowerdir+=/mnt/tmp180,
lowerdir+=/mnt/tmp181,lowerdir+=/mnt/tmp182,lowerdir+=/mnt/tmp183,
lowerdir+=/mnt/tmp184,lowerdir+=/mnt/tmp185,lowerdir+=/mnt/tmp186,
lowerdir+=/mnt/tmp187,lowerdir+=/mnt/tmp188,lowerdir+=/mnt/tmp189,
lowerdir+=/mnt/tmp190,lowerdir+=/mnt/tmp191,lowerdir+=/mnt/tmp192,
lowerdir+=/mnt/tmp193,lowerdir+=/mnt/tmp194,lowerdir+=/mnt/tmp195,
lowerdir+=/mnt/tmp196,lowerdir+=/mnt/tmp197,lowerdir+=/mnt/tmp198,
lowerdir+=/mnt/tmp199,lowerdir+=/mnt/tmp200,lowerdir+=/mnt/tmp201,
lowerdir+=/mnt/tmp202,lowerdir+=/mnt/tmp203,lowerdir+=/mnt/tmp204,
lowerdir+=/mnt/tmp205,lowerdir+=/mnt/tmp206,lowerdir+=/mnt/tmp207,
lowerdir+=/mnt/tmp208,lowerdir+=/mnt/tmp209,lowerdir+=/mnt/tmp210,
lowerdir+=/mnt/tmp211,lowerdir+=/mnt/tmp212,lowerdir+=/mnt/tmp213,
lowerdir+=/mnt/tmp214,lowerdir+=/mnt/tmp215,lowerdir+=/mnt/tmp216,
lowerdir+=/mnt/tmp217,lowerdir+=/mnt/tmp218,lowerdir+=/mnt/tmp219,
lowerdir+=/mnt/tmp220,lowerdir+=/mnt/tmp221,lowerdir+=/mnt/tmp222,
lowerdir+=/mnt/tmp223,lowerdir+=/mnt/tmp224,lowerdir+=/mnt/tmp225,
lowerdir+=/mnt/tmp226,lowerdir+=/mnt/tmp227,lowerdir+=/mnt/tmp228,
lowerdir+=/mnt/tmp229,lowerdir+=/mnt/tmp230,lowerdir+=/mnt/tmp231,
lowerdir+=/mnt/tmp232,lowerdir+=/mnt/tmp233,lowerdir+=/mnt/tmp234,
lowerdir+=/mnt/tmp235,lowerdir+=/mnt/tmp236,lowerdir+=/mnt/tmp237,
lowerdir+=/mnt/tmp238,lowerdir+=/mnt/tmp239,lowerdir+=/mnt/tmp240,
lowerdir+=/mnt/tmp241,lowerdir+=/mnt/tmp242,lowerdir+=/mnt/tmp243,
lowerdir+=/mnt/tmp244,lowerdir+=/mnt/tmp245,lowerdir+=/mnt/tmp246,
lowerdir+=/mnt/tmp247,lowerdir+=/mnt/tmp248,lowerdir+=/mnt/tmp249,
lowerdir+=/mnt/tmp250,lowerdir+=/mnt/tmp251,lowerdir+=/mnt/tmp252,
lowerdir+=/mnt/tmp253,lowerdir+=/mnt/tmp254,lowerdir+=/mnt/tmp255,
lowerdir+=/mnt/tmp256,lowerdir+=/mnt/tmp257,lowerdir+=/mnt/tmp258,
lowerdir+=/mnt/tmp259,lowerdir+=/mnt/tmp260,lowerdir+=/mnt/tmp261,
lowerdir+=/mnt/tmp262,lowerdir+=/mnt/tmp263,lowerdir+=/mnt/tmp264,
lowerdir+=/mnt/tmp265,lowerdir+=/mnt/tmp266,lowerdir+=/mnt/tmp267,
lowerdir+=/mnt/tmp268,lowerdir+=/mnt/tmp269,lowerdir+=/mnt/tmp270,
lowerdir+=/mnt/tmp271,lowerdir+=/mnt/tmp272,lowerdir+=/mnt/tmp273,
lowerdir+=/mnt/tmp274,lowerdir+=/mnt/tmp275,lowerdir+=/mnt/tmp276,
lowerdir+=/mnt/tmp277,lowerdir+=/mnt/tmp278,lowerdir+=/mnt/tmp279,
lowerdir+=/mnt/tmp280,lowerdir+=/mnt/tmp281,lowerdir+=/mnt/tmp282,
lowerdir+=/mnt/tmp283,lowerdir+=/mnt/tmp284,lowerdir+=/mnt/tmp285,
lowerdir+=/mnt/tmp286,lowerdir+=/mnt/tmp287,lowerdir+=/mnt/tmp288,
lowerdir+=/mnt/tmp289,lowerdir+=/mnt/tmp290,lowerdir+=/mnt/tmp291,
lowerdir+=/mnt/tmp292,lowerdir+=/mnt/tmp293,lowerdir+=/mnt/tmp294,
lowerdir+=/mnt/tmp295,lowerdir+=/mnt/tmp296,lowerdir+=/mnt/tmp297,
lowerdir+=/mnt/tmp298,lowerdir+=/mnt/tmp299,lowerdir+=/mnt/tmp300,
lowerdir+=/mnt/tmp301,lowerdir+=/mnt/tmp302,lowerdir+=/mnt/tmp303,
lowerdir+=/mnt/tmp304,lowerdir+=/mnt/tmp305,lowerdir+=/mnt/tmp306,
lowerdir+=/mnt/tmp307,lowerdir+=/mnt/tmp308,lowerdir+=/mnt/tmp309,
lowerdir+=/mnt/tmp310,lowerdir+=/mnt/tmp311,lowerdir+=/mnt/tmp312,
lowerdir+=/mnt/tmp313,lowerdir+=/mnt/tmp314,lowerdir+=/mnt/tmp315,
lowerdir+=/mnt/tmp316,lowerdir+=/mnt/tmp317,lowerdir+=/mnt/tmp318,
lowerdir+=/mnt/tmp319,lowerdir+=/mnt/tmp320,lowerdir+=/mnt/tmp321,
lowerdir+=/mnt/tmp322,lowerdir+=/mnt/tmp323,lowerdir+=/mnt/tmp324,
lowerdir+=/mnt/tmp325,lowerdir+=/mnt/tmp326,lowerdir+=/mnt/tmp327,
lowerdir+=/mnt/tmp328,lowerdir+=/mnt/tmp329,lowerdir+=/mnt/tmp330,
lowerdir+=/mnt/tmp331,lowerdir+=/mnt/tmp332,lowerdir+=/mnt/tmp333,
lowerdir+=/mnt/tmp334,lowerdir+=/mnt/tmp335,lowerdir+=/mnt/tmp336,
lowerdir+=/mnt/tmp337,lowerdir+=/mnt/tmp338,lowerdir+=/mnt/tmp339,
lowerdir+=/mnt/tmp340,lowerdir+=/mnt/tmp341,lowerdir+=/mnt/tmp342,
lowerdir+=/mnt/tmp343,lowerdir+=/mnt/tmp344,lowerdir+=/mnt/tmp345,
lowerdir+=/mnt/tmp346,lowerdir+=/mnt/tmp347,lowerdir+=/mnt/tmp348,
lowerdir+=/mnt/tmp349,lowerdir+=/mnt/tmp350,lowerdir+=/mnt/tmp351,
lowerdir+=/mnt/tmp352,lowerdir+=/mnt/tmp353,lowerdir+=/mnt/tmp354,
lowerdir+=/mnt/tmp355,lowerdir+=/mnt/tmp356,lowerdir+=/mnt/tmp357,
lowerdir+=/mnt/tmp358,lowerdir+=/mnt/tmp359,lowerdir+=/mnt/tmp360,
lowerdir+=/mnt/tmp361,lowerdir+=/mnt/tmp362,lowerdir+=/mnt/tmp363,
lowerdir+=/mnt/tmp364,lowerdir+=/mnt/tmp365,lowerdir+=/mnt/tmp366,
lowerdir+=/mnt/tmp367,lowerdir+=/mnt/tmp368,lowerdir+=/mnt/tmp369,
lowerdir+=/mnt/tmp370,lowerdir+=/mnt/tmp371,lowerdir+=/mnt/tmp372,
lowerdir+=/mnt/tmp373,lowerdir+=/mnt/tmp374,lowerdir+=/mnt/tmp375,
lowerdir+=/mnt/tmp376,lowerdir+=/mnt/tmp377,lowerdir+=/mnt/tmp378,
lowerdir+=/mnt/tmp379,lowerdir+=/mnt/tmp380,lowerdir+=/mnt/tmp381,
lowerdir+=/mnt/tmp382,lowerdir+=/mnt/tmp383,lowerdir+=/mnt/tmp384,
lowerdir+=/mnt/tmp385,lowerdir+=/mnt/tmp386,lowerdir+=/mnt/tmp387,
lowerdir+=/mnt/tmp388,lowerdir+=/mnt/tmp389,lowerdir+=/mnt/tmp390,
lowerdir+=/mnt/tmp391,lowerdir+=/mnt/tmp392,lowerdir+=/mnt/tmp393,
lowerdir+=/mnt/tmp394,lowerdir+=/mnt/tmp395,lowerdir+=/mnt/tmp396,
lowerdir+=/mnt/tmp397,lowerdir+=/mnt/tmp398,lowerdir+=/mnt/tmp399,
lowerdir+=/mnt/tmp400,lowerdir+=/mnt/tmp401,lowerdir+=/mnt/tmp402,
lowerdir+=/mnt/tmp403,lowerdir+=/mnt/tmp404,lowerdir+=/mnt/tmp405,
lowerdir+=/mnt/tmp406,lowerdir+=/mnt/tmp407,lowerdir+=/mnt/tmp408,
lowerdir+=/mnt/tmp409,lowerdir+=/mnt/tmp410,lowerdir+=/mnt/tmp411,
lowerdir+=/mnt/tmp412,lowerdir+=/mnt/tmp413,lowerdir+=/mnt/tmp414,
lowerdir+=/mnt/tmp415,lowerdir+=/mnt/tmp416,lowerdir+=/mnt/tmp417,
lowerdir+=/mnt/tmp418,lowerdir+=/mnt/tmp419,lowerdir+=/mnt/tmp420,
lowerdir+=/mnt/tmp421,lowerdir+=/mnt/tmp422,lowerdir+=/mnt/tmp423,
lowerdir+=/mnt/tmp424,lowerdir+=/mnt/tmp425,lowerdir+=/mnt/tmp426,
lowerdir+=/mnt/tmp427,lowerdir+=/mnt/tmp428,lowerdir+=/mnt/tmp429,
lowerdir+=/mnt/tmp430,lowerdir+=/mnt/tmp431,lowerdir+=/mnt/tmp432,
lowerdir+=/mnt/tmp433,lowerdir+=/mnt/tmp434,lowerdir+=/mnt/tmp435,
lowerdir+=/mnt/tmp436,lowerdir+=/mnt/tmp437,lowerdir+=/mnt/tmp438,
lowerdir+=/mnt/tmp439,lowerdir+=/mnt/tmp440,lowerdir+=/mnt/tmp441,
lowerdir+=/mnt/tmp442,lowerdir+=/mnt/tmp443,lowerdir+=/mnt/tmp444,
lowerdir+=/mnt/tmp445,lowerdir+=/mnt/tmp446,lowerdir+=/mnt/tmp447,
lowerdir+=/mnt/tmp448,lowerdir+=/mnt/tmp449,lowerdir+=/mnt/tmp450,
lowerdir+=/mnt/tmp451,lowerdir+=/mnt/tmp452,lowerdir+=/mnt/tmp453,
lowerdir+=/mnt/tmp454,lowerdir+=/mnt/tmp455,lowerdir+=/mnt/tmp456,
lowerdir+=/mnt/tmp457,lowerdir+=/mnt/tmp458,lowerdir+=/mnt/tmp459,
lowerdir+=/mnt/tmp460,lowerdir+=/mnt/tmp461,lowerdir+=/mnt/tmp462,
lowerdir+=/mnt/tmp463,lowerdir+=/mnt/tmp464,lowerdir+=/mnt/tmp465,
lowerdir+=/mnt/tmp466,lowerdir+=/mnt/tmp467,lowerdir+=/mnt/tmp468,
lowerdir+=/mnt/tmp469,lowerdir+=/mnt/tmp470,lowerdir+=/mnt/tmp471,
lowerdir+=/mnt/tmp472,lowerdir+=/mnt/tmp473,lowerdir+=/mnt/tmp474,
lowerdir+=/mnt/tmp475,lowerdir+=/mnt/tmp476,lowerdir+=/mnt/tmp477,
lowerdir+=/mnt/tmp478,lowerdir+=/mnt/tmp479,lowerdir+=/mnt/tmp480,
lowerdir+=/mnt/tmp481,lowerdir+=/mnt/tmp482,lowerdir+=/mnt/tmp483,
lowerdir+=/mnt/tmp484,lowerdir+=/mnt/tmp485,lowerdir+=/mnt/tmp486,
lowerdir+=/mnt/tmp487,lowerdir+=/mnt/tmp488,lowerdir+=/mnt/tmp489,
lowerdir+=/mnt/tmp490,lowerdir+=/mnt/tmp491,lowerdir+=/mnt/tmp492,
lowerdir+=/mnt/tmp493,lowerdir+=/mnt/tmp494,lowerdir+=/mnt/tmp495,
lowerdir+=/mnt/tmp496,lowerdir+=/mnt/tmp497,lowerdir+=/mnt/tmp498,
lowerdir+=/mnt/tmp499,lowerdir+=/mnt/tmp500,upperdir=/mnt/upper,workdir=/mnt/work uuid=on)

