Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC36228D3DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 20:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgJMSn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 14:43:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:20642 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgJMSn7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 14:43:59 -0400
IronPort-SDR: Kjaudnb4Km4UOzFkEr78oOwAKMo2j6Fby2qry6+9jgA6PlRX2rZACZ6cQcR9GnHz7W71ruYfdL
 5ckJfzbkK+4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="163326911"
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="163326911"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 11:43:58 -0700
IronPort-SDR: Y8yr31bWt2D5ZFUro2P0qp+6A5viSF0HAT183NiudA8pSe1LDbuRDA7sOocHWIOtV1Xh+MKs9o
 UAAH72LnMERw==
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="346281329"
Received: from murawskx-mobl.amr.corp.intel.com (HELO [10.209.9.29]) ([10.209.9.29])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 11:43:58 -0700
Subject: Re: [PATCH RFC V3 5/9] x86/pks: Add PKS kernel API
To:     ira.weiny@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-6-ira.weiny@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzShEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gPGRhdmVAc3I3MS5uZXQ+wsF7BBMBAgAlAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAUCTo3k0QIZAQAKCRBoNZUwcMmSsMO2D/421Xg8pimb9mPzM5N7khT0
 2MCnaGssU1T59YPE25kYdx2HntwdO0JA27Wn9xx5zYijOe6B21ufrvsyv42auCO85+oFJWfE
 K2R/IpLle09GDx5tcEmMAHX6KSxpHmGuJmUPibHVbfep2aCh9lKaDqQR07gXXWK5/yU1Dx0r
 VVFRaHTasp9fZ9AmY4K9/BSA3VkQ8v3OrxNty3OdsrmTTzO91YszpdbjjEFZK53zXy6tUD2d
 e1i0kBBS6NLAAsqEtneplz88T/v7MpLmpY30N9gQU3QyRC50jJ7LU9RazMjUQY1WohVsR56d
 ORqFxS8ChhyJs7BI34vQusYHDTp6PnZHUppb9WIzjeWlC7Jc8lSBDlEWodmqQQgp5+6AfhTD
 kDv1a+W5+ncq+Uo63WHRiCPuyt4di4/0zo28RVcjtzlGBZtmz2EIC3vUfmoZbO/Gn6EKbYAn
 rzz3iU/JWV8DwQ+sZSGu0HmvYMt6t5SmqWQo/hyHtA7uF5Wxtu1lCgolSQw4t49ZuOyOnQi5
 f8R3nE7lpVCSF1TT+h8kMvFPv3VG7KunyjHr3sEptYxQs4VRxqeirSuyBv1TyxT+LdTm6j4a
 mulOWf+YtFRAgIYyyN5YOepDEBv4LUM8Tz98lZiNMlFyRMNrsLV6Pv6SxhrMxbT6TNVS5D+6
 UorTLotDZKp5+M7BTQRUY85qARAAsgMW71BIXRgxjYNCYQ3Xs8k3TfAvQRbHccky50h99TUY
 sqdULbsb3KhmY29raw1bgmyM0a4DGS1YKN7qazCDsdQlxIJp9t2YYdBKXVRzPCCsfWe1dK/q
 66UVhRPP8EGZ4CmFYuPTxqGY+dGRInxCeap/xzbKdvmPm01Iw3YFjAE4PQ4hTMr/H76KoDbD
 cq62U50oKC83ca/PRRh2QqEqACvIH4BR7jueAZSPEDnzwxvVgzyeuhwqHY05QRK/wsKuhq7s
 UuYtmN92Fasbxbw2tbVLZfoidklikvZAmotg0dwcFTjSRGEg0Gr3p/xBzJWNavFZZ95Rj7Et
 db0lCt0HDSY5q4GMR+SrFbH+jzUY/ZqfGdZCBqo0cdPPp58krVgtIGR+ja2Mkva6ah94/oQN
 lnCOw3udS+Eb/aRcM6detZr7XOngvxsWolBrhwTQFT9D2NH6ryAuvKd6yyAFt3/e7r+HHtkU
 kOy27D7IpjngqP+b4EumELI/NxPgIqT69PQmo9IZaI/oRaKorYnDaZrMXViqDrFdD37XELwQ
 gmLoSm2VfbOYY7fap/AhPOgOYOSqg3/Nxcapv71yoBzRRxOc4FxmZ65mn+q3rEM27yRztBW9
 AnCKIc66T2i92HqXCw6AgoBJRjBkI3QnEkPgohQkZdAb8o9WGVKpfmZKbYBo4pEAEQEAAcLB
 XwQYAQIACQUCVGPOagIbDAAKCRBoNZUwcMmSsJeCEACCh7P/aaOLKWQxcnw47p4phIVR6pVL
 e4IEdR7Jf7ZL00s3vKSNT+nRqdl1ugJx9Ymsp8kXKMk9GSfmZpuMQB9c6io1qZc6nW/3TtvK
 pNGz7KPPtaDzvKA4S5tfrWPnDr7n15AU5vsIZvgMjU42gkbemkjJwP0B1RkifIK60yQqAAlT
 YZ14P0dIPdIPIlfEPiAWcg5BtLQU4Wg3cNQdpWrCJ1E3m/RIlXy/2Y3YOVVohfSy+4kvvYU3
 lXUdPb04UPw4VWwjcVZPg7cgR7Izion61bGHqVqURgSALt2yvHl7cr68NYoFkzbNsGsye9ft
 M9ozM23JSgMkRylPSXTeh5JIK9pz2+etco3AfLCKtaRVysjvpysukmWMTrx8QnI5Nn5MOlJj
 1Ov4/50JY9pXzgIDVSrgy6LYSMc4vKZ3QfCY7ipLRORyalFDF3j5AGCMRENJjHPD6O7bl3Xo
 4DzMID+8eucbXxKiNEbs21IqBZbbKdY1GkcEGTE7AnkA3Y6YB7I/j9mQ3hCgm5muJuhM/2Fr
 OPsw5tV/LmQ5GXH0JQ/TZXWygyRFyyI2FqNTx4WHqUn3yFj8rwTAU1tluRUYyeLy0ayUlKBH
 ybj0N71vWO936MqP6haFERzuPAIpxj2ezwu0xb1GjTk4ynna6h5GjnKgdfOWoRtoWndMZxbA
 z5cecg==
Message-ID: <29e9b8f1-35d6-d1d4-661d-a36fd296b593@intel.com>
Date:   Tue, 13 Oct 2020 11:43:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009194258.3207172-6-ira.weiny@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static inline void pks_update_protection(int pkey, unsigned long protection)
> +{
> +	current->thread.saved_pkrs = update_pkey_val(current->thread.saved_pkrs,
> +						     pkey, protection);
> +	preempt_disable();
> +	write_pkrs(current->thread.saved_pkrs);
> +	preempt_enable();
> +}

Why does this need preempt count manipulation in addition to the
get/put_cpu_var() inside of write_pkrs()?

> +/**
> + * PKS access control functions
> + *
> + * Change the access of the domain specified by the pkey.  These are global
> + * updates.  They only affects the current running thread.  It is undefined and
> + * a bug for users to call this without having allocated a pkey and using it as
> + * pkey here.
> + *
> + * pks_mknoaccess()
> + *     Disable all access to the domain
> + * pks_mkread()
> + *     Make the domain Read only
> + * pks_mkrdwr()
> + *     Make the domain Read/Write
> + *
> + * @pkey the pkey for which the access should change.
> + *
> + */
> +void pks_mknoaccess(int pkey)
> +{
> +	pks_update_protection(pkey, PKEY_DISABLE_ACCESS);
> +}
> +EXPORT_SYMBOL_GPL(pks_mknoaccess);

These are named like PTE manipulation functions, which is kinda weird.

What's wrong with: pks_disable_access(pkey) ?

> +void pks_mkread(int pkey)
> +{
> +	pks_update_protection(pkey, PKEY_DISABLE_WRITE);
> +}
> +EXPORT_SYMBOL_GPL(pks_mkread);

I really don't like this name.  It doesn't make readable, or even
read-only, *especially* if it was already access-disabled.

> +static const char pks_key_user0[] = "kernel";
> +
> +/* Store names of allocated keys for debug.  Key 0 is reserved for the kernel.  */
> +static const char *pks_key_users[PKS_NUM_KEYS] = {
> +	pks_key_user0
> +};
> +
> +/*
> + * Each key is represented by a bit.  Bit 0 is set for key 0 and reserved for
> + * its use.  We use ulong for the bit operations but only 16 bits are used.
> + */
> +static unsigned long pks_key_allocation_map = 1 << PKS_KERN_DEFAULT_KEY;
> +
> +/*
> + * pks_key_alloc - Allocate a PKS key
> + *
> + * @pkey_user: String stored for debugging of key exhaustion.  The caller is
> + * responsible to maintain this memory until pks_key_free().
> + */
> +int pks_key_alloc(const char * const pkey_user)
> +{
> +	int nr;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_PKS))
> +		return -EINVAL;

I'm not sure I like -EINVAL for this.  I thought we returned -ENOSPC for
this case for user pkeys.

> +	while (1) {
> +		nr = find_first_zero_bit(&pks_key_allocation_map, PKS_NUM_KEYS);
> +		if (nr >= PKS_NUM_KEYS) {
> +			pr_info("Cannot allocate supervisor key for %s.\n",
> +				pkey_user);
> +			return -ENOSPC;
> +		}
> +		if (!test_and_set_bit_lock(nr, &pks_key_allocation_map))
> +			break;
> +	}
> +
> +	/* for debugging key exhaustion */
> +	pks_key_users[nr] = pkey_user;
> +
> +	return nr;
> +}
> +EXPORT_SYMBOL_GPL(pks_key_alloc);
> +
> +/*
> + * pks_key_free - Free a previously allocate PKS key
> + *
> + * @pkey: Key to be free'ed
> + */
> +void pks_key_free(int pkey)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_PKS))
> +		return;
> +
> +	if (pkey >= PKS_NUM_KEYS || pkey <= PKS_KERN_DEFAULT_KEY)
> +		return;

This seems worthy of a WARN_ON_ONCE() at least.  It's essentially
corrupt data coming into a kernel API.
